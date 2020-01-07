import React from 'react';
import MonacoEditor, { MonacoDiffEditor }  from 'react-monaco-editor';
import ReactResizeDetector from 'react-resize-detector';

export default class UDMonacoEditor extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
       code: props.code
    }
  }



  onIncomingEvent(eventName, event) {
      if (event.type === "setState") {
          this.setState({...event.state.attributes})
      }
      else if (event.type === "addElement") {
        var code = this.state.code;
        code += event.elements;
        this.setState({
          code
        })
      }
      else if (event.type === "requestState") {
        UniversalDashboard.post(`/api/internal/component/element/sessionState/${event.requestId}`, {
          attributes: {
            code: this.state.code
          }
        });
      }
  }

  onChange(newValue) {
     this.setState({
       code: newValue
     });
  }  

  componentWillMount() {
    this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
  }

  componentWillUnmount() {
     UniversalDashboard.unsubscribe(this.pubSubToken);
  }

  editorDidMount(editor, monaco) {
    this.editor = editor;
  }

  onResize() 
  {
    if (this.editor) {
      this.editor.layout();
    }
  }

  render() {

     var control = this.props.original ? 
     
     <MonacoDiffEditor 
        language={this.props.language}
        theme={this.props.theme}
        value={this.state.code}
        original={this.props.original}
        options={this.props}
        height={this.props.height}
        width={this.props.width}
        onChange={this.onChange.bind(this)}
        editorDidMount={this.editorDidMount.bind(this)}/> : 
     
     <MonacoEditor
          language={this.props.language}
          theme={this.props.theme}
          value={this.state.code}
          options={this.props}
          height={this.props.height}
          width={this.props.width}
          onChange={this.onChange.bind(this)}
          editorDidMount={this.editorDidMount.bind(this)}/>;

     if (this.props.autosize)
     {
        return (
          <ReactResizeDetector handleWidth handleHeight onResize={this.onResize.bind(this)}>
            {control}
          </ReactResizeDetector>
        )
     }

     return control;
  }
}