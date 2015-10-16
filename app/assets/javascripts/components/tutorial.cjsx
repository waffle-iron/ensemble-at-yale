React     = require 'react'
HelpModal = require './help-modal'
DraggableModal  = require 'components/draggable-modal'


module.exports = React.createClass
  displayName: 'Tutorial'

  propTypes:
    tutorial: React.PropTypes.object.isRequired
    onCloseTutorial: React.PropTypes.func.isRequired

  getInitialState:->
    currentTask: @props.tutorial.first_task
    nextTask: @props.tutorial.tasks[@props.tutorial.first_task].next_task
    completedSteps: 0
    doneButtonLabel: "Next"

  advanceToNextTask:->
    if @props.tutorial.tasks[@state.currentTask].next_task == null
      @props.onCloseTutorial()

    else
      @setState
        currentTask: @state.nextTask
        nextTask: @props.tutorial.tasks[@state.nextTask].next_task
        completedSteps: @state.completedSteps + 1

  render:->
    helpContent = @props.tutorial.tasks[@state.currentTask].help
    taskKeys = Object.keys(@props.tutorial.tasks)

    if @state.nextTask != null
      doneButtonLabel = "Next"
    else
      doneButtonLabel = "Done"

    <DraggableModal header={helpContent.title ? 'Help'} doneButtonLabel={doneButtonLabel} onDone={@advanceToNextTask} width={800} classes="help-modal" currentStepIndex={@state.completedSteps} closeButton=true onClose={@props.onCloseTutorial} >
      <div dangerouslySetInnerHTML={{__html: marked( helpContent.body ) }} />
    </DraggableModal>
