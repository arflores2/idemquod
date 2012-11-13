package com.menlo.idemquod

import com.grailsrocks.authentication.AuthenticationUser

class AskQuestionsJob {

  def mailService

  static triggers = {
    cron name: "search", startDelay: 0, cronExpression: "0 0/1 * * * ?" //execute everyday at noon
  }

  /**
   * AskQuestionsJob execute
   * for each user, get list of questions
   * for each question send email
   */
  def execute() {

    def iqUsers = AuthenticationUser.list(),
        questions

    println "looping through users"
    for(user in iqUsers) {
      questions = Question.findAllByAuthenticationUser(user)

      println "looping through questions"
      for(q in questions) {

        println "sending email"
        mailService.sendMail{
          to user.email
          subject q.question
          body q.answer
        }
      }
    }
  }
}
