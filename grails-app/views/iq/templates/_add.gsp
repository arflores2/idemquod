<g:form name="addQuestionForm" controller="questions" action="add" class="form-horizontal">
  <div class="control-group">
    <label class='control-label' for='inputQuestion'>
      Question
    </label>
    <div class='controls'>
      <input type='text' id='inputQuestion' name='question' placeholde='Enter you Question'>
    </div>
  </div>
  <div class="control-group">
    <label class='control-label' for='inputAnswer'>
      Answer
    </label>
    <div class='controls'>
      <input type='text' id='inputAnswer' name='answer' placeholde='The Answer is'>
    </div>
  </div>
  <div>
    <button type="submit" class="btn">Add Question</button>
  </div>
</g:form>