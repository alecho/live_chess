# LiveChess

This is my entry in Phoenix Phrenzy, showing off what Phoenix and LiveView can do.

![Live Chess preview](https://media.giphy.com/media/SswzyvdHS6a88BSA72/giphy.gif "Live Chess")

Play chess against the Stockfish 10 chess engine. This application uses Chex. I chess library and OTP application I wrote for the purpose of this app. Together they use Elixir Ports, OTP, UCI (Universal Chess Interface), Phoenix and Phoenix Live View to play chess live in a web browser.

[Demo here](https://chess.alecho.com/)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Configure [Chex](https://github.com/alecho/chex) to point to your Stockfish binary
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
