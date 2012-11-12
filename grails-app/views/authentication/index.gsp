<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <meta name="layout" content="main"/>
</head>

<body>
<auth:ifLoggedIn>
    You are currently logged in as: <auth:user/>
    <h2>Log out</h2>
    <auth:form authAction="logout" success="[controller: 'authentication', action: 'index']"
               error="[controller: 'authentication', action: 'index']">
        <g:actionSubmit value="Log out"/>
    </auth:form>
</auth:ifLoggedIn>
<auth:ifUnconfirmed>
    You've registered but we're still waiting to confirm your account. <g:link
        action="reconfirm">Click here to send a new confirmation request</g:link> if you missed it the first time.
</auth:ifUnconfirmed>
<auth:ifNotLoggedIn>
    <div class="container">
        <div id="login-top" class="section">
            <!-- button group -->
            <div class="row login-row">
                <div class="span12">
                    <div id="login-button-group" class="btn-group" data-toggle="buttons-radio">
                        <button id='login-button'
                                class="btn ${params?.id == 'login' ? 'active' : (!params.id) ? 'active' : ''}">Login</button>
                        <button id='signup-button'
                                class="btn ${params?.id == 'signup' ? 'active' : ''}">Sign Up</button>
                    </div>
                </div>
            </div>
        <!-- end button group -->

            <g:if test="${flash.authenticationFailure}">
                Sorry but your login/signup failed - reason: <g:message
                    code="authentication.failure.${flash.authenticationFailure.result}"/><br/>
            </g:if>
            <g:hasErrors bean="${flash.loginFormErrors}" field="login">
                <!--
              <div class='alert alert-error'>
                <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="login"/>
                </div>
                -->
            </g:hasErrors>
            <g:hasErrors bean="${flash.loginFormErrors}" field="password">

                <!--
              <div class='alert alert-error'>
                <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="password"/>
                </div>
                -->
            </g:hasErrors>

        <!-- login info -->
            <auth:form
                    authAction="login"
                    success="[controller: 'questions', action: 'index']"
                    error="[controller: 'authentication', action: 'index']">

                <div id="login-form" class="section">
                    <div class="row login-row">
                        <div class="span3 login-col">
                            <div class="control-group">
                                <div class="controls">

                                    <g:textField placeholder="username" name="login"
                                                 value="${flash.loginForm?.login?.encodeAsHTML()}"/>
                                    <!--<input type="text" id="login" placeholder="youremail@email.com" />-->

                                </div>
                            </div>

                            <div class="control-group clear-bottom">
                                <div class="controls">

                                    <g:passwordField name="password" placeholder="password" id="password"
                                                     class="clear-bottom"/>
                                    <!--<input class="clear-bottom" type="password" id="password" placeholder="password" />-->

                                </div>
                            </div>

                            <div class="pull-right txt-mini">
                                <a href="#">Forgot Password?</a>
                            </div>
                        </div>
                    </div>

                    <!-- submit button -->
                    <div class="row login-row">
                        <div clas="span12">
                            <g:actionSubmit class="btn btn-large btn-primary" value="Login"/>
                        </div>
                    </div>
                    <!-- end submit button -->
                </div>
            </auth:form>
        <!-- end login info -->

        <!-- new user info -->
            <auth:form
                    authAction="signup"
                    success="[controller: 'questions', action: 'index']"
                    error="[controller: 'authentication', action: 'index']">

                <div id="signup-form" class="section" >
                    <div class="row login-row">
                        <div class="span3 login-col">
                            <div class="control-group">
                                <div class="controls">

                                    <g:hasErrors bean="${flash.signupFormErrors}" field="login">
                                        <div class='alert alert-error'>

                                            <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="login"/>
                                        </div>
                                    </g:hasErrors>

                                    <g:textField placeholder="username" name="login"
                                                 value="${flash.signupForm?.login?.encodeAsHTML()}"/>
                                <!--<input type="text" id="login" placeholder="youremail@email.com" />-->

                                </div>
                            </div>

                            <div class="control-group">
                                <div class="controls">

                                    <g:hasErrors bean="${flash.signupFormErrors}" field="email">
                                        <div class='alert alert-error'>
                                            <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="email"/>
                                        </div>
                                    </g:hasErrors>

                                    <g:textField placeholder="youremail@email.com" name="email"
                                                 value="${flash.signupForm?.email?.encodeAsHTML()}"/>
                                <!--<input type="text" id="login" placeholder="youremail@email.com" />-->

                                </div>
                            </div>

                            <div class="control-group">
                                <div class="controls">

                                    <g:hasErrors bean="${flash.signupFormErrors}" field="password">
                                        <div class='alert alert-error'>
                                            <g:renderErrors bean="${flash.signupFormErrors}" as="list"
                                                            field="password"/>
                                        </div>
                                    </g:hasErrors>

                                    <g:passwordField name="password" placeholder="password" id="password"/>
                                <!--<input class="clear-bottom" type="password" id="password" placeholder="password" />-->

                                </div>
                            </div>

                            <div class="control-group">
                                <div class="controls">

                                    <g:hasErrors bean="${flash.signupFormErrors}" field="passwordConfirm">
                                        <div class='alert alert-error'>
                                            <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="confirm"/>
                                        </div>
                                    </g:hasErrors>

                                    <g:passwordField name="passwordConfirm" placeholder="confirm password" id="passwordConfirm"/>
                                <!--<input class="clear-bottom" type="password" id="password" placeholder="password" />-->

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- submit button -->
                    <div class="row login-row">
                        <div clas="span12">
                            <g:actionSubmit class="btn btn-large btn-primary" value="Sign up"/>
                        </div>
                    </div>
                    <!-- end submit button -->
                </div>
            </auth:form>
        <!-- end new user info -->
        </div>
    </div>
</auth:ifNotLoggedIn>
</body>
</html>