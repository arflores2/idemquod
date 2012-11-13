package com.menlo.idemquod

import com.grailsrocks.authentication.AuthenticationUser

class IqController {

  def authenticationService

  def index() {
    if(!authenticationService.isLoggedIn(request)) {
      redirect(controller: 'authentication')
    }

    def currentUserPrincipal = authenticationService.getUserPrincipal(),
        currentUser = AuthenticationUser.get(currentUserPrincipal.id),
        listOfUserQuestions = Question.findAllByAuthenticationUser(currentUser)


    [questions: listOfUserQuestions]
  }
}
