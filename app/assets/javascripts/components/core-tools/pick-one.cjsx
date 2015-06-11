React = require 'react'
GenericTask = require './generic'
# Markdown = require '../../components/markdown'

NOOP = Function.prototype

# Summary = React.createClass
#   displayName: 'SingleChoiceSummary'

#   getDefaultProps: ->
#     task: null
#     annotation: null
#     expanded: false

#   getInitialState: ->
#     expanded: @props.expanded

#   render: ->
#     <div className="classification-task-summary">
#       <div className="question">
#         {@props.task.question}
#         {if @state.expanded
#           <button type="button" className="toggle-more" onClick={@setState.bind this, expanded: false, null}>Less</button>
#         else
#           <button type="button" className="toggle-more" onClick={@setState.bind this, expanded: true, null}>More</button>}
#       </div>
#       <div className="answers">
#         {if @state.expanded
#           for answer, i in @props.task.answers
#             answer._key ?= Math.random()
#             <div key={answer._key} className="answer">
#               {if i is @props.annotation.value
#                 <i className="fa fa-check-circle-o fa-fw"></i>
#               else
#                 <i className="fa fa-circle-o fa-fw"></i>}
#               {@props.task.answers[i].label}
#             </div>
#         else if @props.annotation.value?
#           <div className="answer">
#             <i className="fa fa-check-circle-o fa-fw"></i>
#             {@props.task.answers[@props.annotation.value].label}
#           </div>
#         else
#           <div className="answer">No answer</div>}
#       </div>
#     </div>

module.exports = React.createClass
  displayName: 'SingleChoiceTask'

  statics:
    # Summary: Summary # don't use Summary (yet?)

    getDefaultAnnotation: ->
      value: null

  getDefaultProps: ->
    task: null
    annotation: null
    onChange: NOOP

  render: ->
    answers = for k, answer of @props.task.tool_config.options

      answer._key ?= Math.random()
      checked = k is @props.annotation.value

      classes = ['minor-button']
      classes.push 'active' if checked
      classes = classes.join ' '

      <label key={answer._key} className={classes}>
        <input type="radio" name="input0" value={k} checked={checked} onChange={@handleChange.bind this, k} />
        <span>{answer.label}</span>
      </label>

    <GenericTask ref="inputs" question={@props.task.instruction} help={@props.task.help} answers={answers} />

  handleChange: (index, e) ->
    console.log "PLEASE HANDLE CHANGE"
    console.log "PLEASE HANDLE CHANGE"
    console.log "PLEASE HANDLE CHANGE"
    if e.target.checked
      checked = $(@refs.inputs.getDOMNode()).find('input[type=radio]:checked')
      @props.onChange({
        value: checked.val()
      })
      @forceUpdate() # update the radiobuttons after selection

window.React = React
