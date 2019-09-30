// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

// Configure liveview socket
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let Hooks = {}
Hooks.Piece = {
  mounted(){
    this.el.addEventListener("dragstart", e => {
      e.dataTransfer.effectAllowed = "move"
      e.dataTransfer.setData("from-square", e.target.dataset.currentSquare);
    });

    this.el.addEventListener("dragover", e => {
      e.preventDefault();
    });

    this.el.addEventListener("drop", e => {
      e.preventDefault();
      let from = event.dataTransfer.getData("from-square");
      let to = e.target.dataset.currentSquare;
      e.target.className = e.target.className.replace(" square-dragged-over", "");

      this.pushEvent("move-piece", {from, to});
    });
  }
};

Hooks.Square = {
  mounted() {
    this.el.addEventListener("dragenter", e => {
      e.target.className = e.target.className.concat(" square-dragged-over");
    });

    this.el.addEventListener("dragleave", e => {
      e.target.className = e.target.className.replace(" square-dragged-over", "");
    });

    this.el.addEventListener("dragover", e => {
      e.preventDefault();
    });

    this.el.addEventListener("drop", e => {
      e.preventDefault();
      let from = event.dataTransfer.getData("from-square");
      let to = e.target.attributes['phx-value-name'].value;
      e.target.className = e.target.className.replace(" square-dragged-over", "");

      this.pushEvent("move-piece", {from, to});
    });
  }
};

let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks})
liveSocket.connect()
