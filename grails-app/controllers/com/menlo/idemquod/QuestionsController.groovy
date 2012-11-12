package com.menlo.idemquod

import com.grailsrocks.authentication.AuthenticationUser

import grails.converters.JSON

class QuestionsController {

  def authenticationService

  def index() {
  	def tmp = AuthenticationUser.list()
  	render tmp as JSON
  }

  def list() {

    def currentUser, currentUserPrincipal

    if(authenticationService.isLoggedIn(request)) {
      currentUserPrincipal = authenticationService.getUserPrincipal()
      currentUser = AuthenticationUser.get(currentUserPrincipal.id)
      def listOfUserQuestions = Question.findAllByAuthenticationUser(currentUser)
      render listOfUserQuestions as JSON
    }
  }

  /**
   * adds a single question assigned to the current authenticated user
   * expects POST/GET params:
   * @param params.question
   * @param params.answer
   */
  def add() {

    //required values
    if(!params.question || !params.answer) {
      response.status = 500
      render "Question[add] requires question and answer values"
      return
    }

    def currentUserPrincipal = authenticationService.getUserPrincipal()
    def currentUser = AuthenticationUser.get(currentUserPrincipal.id)
    def question = params.question
    def answer = params.answer

    //@TODO check if question is the same
    def q = new Question(
      question: question,
      answer: answer,
      authenticationUser: currentUser
    ).save(flush: true) //save when created

    //return question that was created
    render q as JSON
  }
}

