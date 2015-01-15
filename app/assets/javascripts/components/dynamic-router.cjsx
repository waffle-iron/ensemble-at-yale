React = require("react")
{Router, Routes, Route, Link} = require 'react-router'

MainHeader         = require('../partials/main-header')
HomePageController = require("./home-page-controller")
ImageSubjectViewer_mark = require('./image-subject-viewer-mark')
ImageSubjectViewer_transcribe = require('./image-subject-viewer-transcribe')


transcribe_steps = [
    {
      key: 0,
      type: 'date', # type of input
      field_name: 'date',
      label: 'Date',
      instruction: 'Please type-in the log date.'
    },
    {
      key: 1,
      type: 'text',
      field_name: 'journal_entry',
      label: 'Journal Entry',
      instruction: 'Please type-in the journal entry for this day.'
    },
    {
      key: 2,
      type: 'textarea',
      field_name: 'other_entry',
      label: 'Other Entry',
      instruction: 'Type something, anything.'
    }
]
pages = [
  {
    name:    'info', 
    content: 'I am a content thingie'
  },
  {
    name:    'science', 
    content: 'I am science'
  }
]


DynamicRouter = React.createClass

  getInitialState: ->
    transcribe_workflow: null

  componentDidMount: ->
    $.getJSON '/workflows/transcribe', (result) => 
      # console.log 'SETTING WORKFLOW: ', result
      @setState transcribe_workflow: result

  controllerForPage:(p)->
    React.createClass
      displayname: "#{p.name}_page"
      render:->
        <div>
          {p.content}
        </div>

  render:->
    return null if @state.transcribe_workflow is null
      
    <div className="panoptes-main">
      <MainHeader />
      <div className="main-content">
        <Routes>
          <Route path='/' handler={HomePageController} name="root" />
          <Route path='/mark' handler={ImageSubjectViewer_mark} name='mark' task='mark' />
          <Route 
            path='/transcribe' 
            handler={ImageSubjectViewer_transcribe} 
            name='transcribe' 
            task='transcribe'
            transcribeSteps={@state.transcribe_workflow.tasks}  
          />

          {pages.map (p, key)=>
            <Route path="/#{p.name}" handler={@controllerForPage(p)} name={p.name} key={key} />
          }
        </Routes>
      </div>
    </div>
module.exports = DynamicRouter
