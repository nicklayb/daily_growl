import {markdown} from "@codemirror/lang-markdown"
import {EditorView, basicSetup} from "codemirror"
import { vim } from "@replit/codemirror-vim"

const DEBOUNCE_TIMER = 50

export default {
  mounted() {
    const element = this.el
    const value = JSON.parse(this.el.dataset.documentValue)
    console.log(value)
    this.view = new EditorView({
      doc: value,
      parent: element,
      extensions: [
        basicSetup,
        markdown(),
        vim(),
        EditorView.updateListener.of((e) => {
          if (e.docChanged) {
            this.handleUpdate(e.state.doc)
          } 
        })
      ]
    })
  },
  handleUpdate(doc) {
    clearTimeout(this.timer)
    this.timer =  setTimeout(() => {
      const body = doc.toString();
      this.pushEvent("Editor:documentUpdated", { body })
    }, DEBOUNCE_TIMER);
  }
}
