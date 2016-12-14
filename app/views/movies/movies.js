movies.js

import React, { Component } from 'react';
import Helmet from 'react-helmet';
import { asyncConnect } from 'redux-connect';
import { initialize, SubmissionError } from 'redux-form';

import { ItemRows, ConversationItem, NewConversationForm, ConversationPage } from 'components';
import { messageActions, userActions, notifActions } from 'reducks/actions';
import { messagesByTargetSelector, networkSelector } from 'reducks/selectors';
import { mapToArray } from 'reducks/helpers';
@asyncConnect([
{
  promise: ({ store: { dispatch }}) => dispatch(userActions.getNetwork())
},
{
  promise: ({location: { query }, store: { dispatch }}) => {
    if(query.new){
      const newMessageRecipients = query.new.split(',');
      userActions.getUserProfiles(newMessageRecipients);
    }
  }
}],
(state, ownProps) => {
  let newMessageRecipients = new Set();
  if(ownProps.location.query.new)
    newMessageRecipients = new Set(ownProps.location.query.new.split(',').map(Number));
  const network = state.user_profiles.network.union(newMessageRecipients);
  return {
    conversations: state.messages.conversations,
    network: mapToArray(networkSelector(state, network))
  }
},
{ ...messageActions, ...notifActions, initialize })
export default class Messages extends Component {
  constructor(props){
    super(props);
    this.newConversation = this.newConversation.bind(this);
    this.state = {
      creatingNewMessage: !!props.location.query.new,
      selectedConversationId: null,
      initialRecipients: props.location.query.new ? props.location.query.new.split(',').map(Number) : [],
      initialSubject: props.location.query.subject || ""
    }
  }

  componentDidMount(){
    this.props.initialize('new_conversation', {
      recipients: this.state.initialRecipients,
      name: this.state.initialSubject
    })
  }

  newConversation(){
    this.setState({selectedConversationId: null, creatingNewMessage: true})
  }

  submitNewConversation = (data) => {
    return this.props.createConversation({members: data.recipients, name: data.name}).then(
      (result) => {
        this.props.postToConversation(result.data.id, {message: data.message});
        this.props.notifSend({
          message: `Sent Message`,
          kind: 'success',
          dismissAfter: 2000
        });
        this.props.initialize('new_conversation', {});
        this.setState({selectedConversationId: null, creatingNewMessage: false})
      },
      err => {
        this.props.notifSend({
          message: err.reason,
          kind: 'danger',
          dismissAfter: 2000
        });
        throw new SubmissionError({})
      })
  }

  toggleConversation(convo, event){
    this.setState({selectedConversationId: convo.id, creatingNewMessage: false})
    this.props.getConversation(convo.id).then(() => this.forceUpdate())
    // todo callback this.forceUpdate after above, as setState is async.
    // todo nice additional store toggled in url & restore toggled by url (same goes for newconvo)
  }

  render() {
    const t10s = require('./translations')();
    const style = require('./Messages.scss');

    const conversations = this.props.conversations;
    const conversationsElements = [];
    for(var i in conversations){
      const item = conversations[i];
      conversationsElements.push(
        <ConversationItem
          conversation={item}
          handleClick={this.toggleConversation.bind(this, item)}
          key={item.id}/>
      );
    }
    return (
      <div className="container">
        <Helmet title={t10s.title} />
        <h2 className="pageTitle">{t10s.title}</h2>
        <div className="row">
          <div className="col-md-3" style={{flexDirection: "column", flexWrap: "wrap", alignItems: "flex-start"}}>
            <div style={{width: "100%"}}>
              <button style={{width: "100%", borderRadius: 0}} className="btn-sm btn-primary" onClick={this.newConversation}>{t10s.newConvo}</button>
            </div>
            <ul className={style.conversationList}>
              {conversationsElements}
            </ul>
          </div>
          <div className="col-md-9">
            {this.state.selectedConversationId &&
              <ConversationPage conversationId={this.state.selectedConversationId}/>
            }
            {!this.state.selectedConversationId && !this.state.creatingNewMessage &&
              <h4>--- {t10s.selectConvo} {/* Shouldn't really occur ever, either select most recent convo by default or if none, be creatingNewMessage */}</h4>
            }
            {this.state.creatingNewMessage &&
              <NewConversationForm network={this.props.network} onSubmit={this.submitNewConversation} />
            }
          </div>
        </div>
      </div>
    );
  }
}
