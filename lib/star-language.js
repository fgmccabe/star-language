'use babel';

import StarLanguageView from './star-language-view';
import { CompositeDisposable } from 'atom';

export default {

  StarLanguageView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.StarLanguageView = new StarLanguageView(state.StarLanguageViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.StarLanguageView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'star-language:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.StarLanguageView.destroy();
  },

  serialize() {
    return {
      StarLanguageViewState: this.StarLanguageView.serialize()
    };
  },

  toggle() {
    console.log('StarLanguageViewLanguage was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
