package com.menlo.idemquod

import com.grailsrocks.authentication.AuthenticatedUser
import com.grailsrocks.authentication.LoginForm
import com.grailsrocks.authentication.SignupForm

import grails.converters.JSON

class AuthenticationController {
  def defaultAction = "index"
  def authenticationService

  def index = {
    if( authenticationService.isLoggedIn(request) ) {
      redirect([controller: 'questions'])
    }
  }

  def login(LoginForm form) {

    def urls = extractParams()

    if (!form.hasErrors()) {
      def loginResult = authenticationService.login( form.login, form.password)
      if (loginResult.result == 0) {
        flash.loginForm = form
        if (log.debugEnabled) log.debug("Login succeeded for [${form.login}]")
        redirect(flash.authSuccessURL ? flash.authSuccessURL : urls.success)
      } else {
        flash.loginForm = form

        flash.authenticationFailure = loginResult
        if (log.debugEnabled) log.debug("Login failed for [${form.login}] - reason: ${loginResult.result}")
        redirect(flash.authFailureURL ? flash.authFailureURL : urls.error)
      }
    } else {
      flash.authenticationFailure = [result: 5]
      flash.loginForm = form
      flash.loginFormErrors = form.errors // Workaround for grails bug
      if (log.debugEnabled) log.debug("Login failed for [${form.login}] - form invalid: ${form.errors}")
      redirect(flash.authErrorURL ? flash.authErrorURL : urls.error)
    }

  }

  def signup(SignupForm form) {

    def urls = extractParams()

    if (!form.hasErrors()) {

      def signupResult = authenticationService.signup(
              login:form.login,
              password:form.password,
              email:form.email,
              immediate:true,
              extraParams:params
      )

      if ((signupResult.result == 0) || (signupResult.result == AuthenticatedUser.AWAITING_CONFIRMATION)) {
        //successful login

        if (log.debugEnabled) {
          if (signupResult == AuthenticatedUser.AWAITING_CONFIRMATION) {
            log.debug("Signup succeeded pending email confirmation for [${form.login}] / [${form.email}]")
          } else {
            log.debug("Signup succeeded for [${form.login}]")
          }
        }

        redirect(flash.authSuccessURL ? flash.authSuccessURL : urls.success)

      } else {
        //signup failed during signup action
        flash.authenticationFailure = signupResult
        flash.signupForm = form

        if (log.debugEnabled) log.debug("Signup failed for [${form.login}] reason ${signupResult.result}") {
          redirect(flash.authErrorURL ? flash.authErrorURL : urls.error)
        }
      }
    } else {


      //signup failed during validation or awaiting approval
      flash.signupForm = form
      flash.signupFormErrors = form.errors // Workaround for grails bug in 0.5.6
      if (log.debugEnabled) log.debug("Signup failed for [${form.login}] - form invalid: ${form.errors}")

      render flash as JSON
      redirect(flash.authErrorURL ? flash.authErrorURL : urls.error)
    }
  }

  def logout = {
    def urls = extractParams()

    urls.success['id'] = 'login'
    urls.success['action'] = 'index'

    authenticationService.logout( authenticationService.sessionUser )
    redirect(flash.authSuccessURL ? flash.authSuccessURL : urls.success)
  }

  def extractParams() {
    def redirectParams = [success:[:], error:[:]]
    params.keySet().each() { name ->
      if (name.startsWith("success_") || name.startsWith('error_') || name.startsWith('action')) {
        def underscore = name.indexOf('_')
        if (underscore >= name.size()-1) return
        def prefix = name[0..underscore-1]
        def urlParam = name[underscore+1..-1]
        if (urlParam != 'url') {
          if( name == 'action' ) {
            //render params
            redirectParams['success']['id'] = params[name]
            redirectParams['error']['id'] = params[name]
          }
          else {
            redirectParams[prefix][urlParam] = params[name]
          }
        }
      }
    }
    return redirectParams
  }

}
