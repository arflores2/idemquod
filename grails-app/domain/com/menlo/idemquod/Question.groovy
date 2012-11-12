package com.menlo.idemquod

import com.grailsrocks.authentication.AuthenticationUser

class Question {

  String question
  String answer
  AuthenticationUser authenticationUser

  static constraints = {
    authenticationUser nullable: false
  }
}
