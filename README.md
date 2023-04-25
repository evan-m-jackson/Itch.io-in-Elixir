# ItchClone

## Requirements

Make sure to have the following installed:

- Elixir https://elixir-lang.org/install.html
- NPM https://nodejs.org/en (Unless it's already installed on your machine)
- Postgres https://www.postgresql.org/

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## For Developers

If you would like to run this project locally on your machine, then you will need to create a `.env.dev` file in the main project root. The file's content should be in this format:

    export AWS_ACCESS_KEY={AWS_ACCESS_KEY}
    export AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}
    export AWS_S3_BUCKET={AWS_S3_BUCKET}
    export GOOGLE_CLIENT_ID={GOOGLE_CLIENT_ID}
    export GOOGLE_CLIENT_SECRET={GOOGLE_CLIENT_SECRET}

For the AWS access key and secret access key, please follow the instructions here: https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html

And then you can create an AWS S3 bucket by following these instructions: https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html. These instructions also go over how to enable a bucket to host a static website. Only Steps 1-4 are necessary for this project.

Finally, for the Google Client ID and Client Secret, please follow these instructions: https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid. Once the Client ID and Secret are created, you will need to add a Redirect URI. Here is a helpful Stack Overflow post that goes over this: https://stackoverflow.com/questions/16693653/how-to-add-or-change-return-uri-in-google-console-for-oauth2. The redirect uri you will need to add is `http://localhost:4000/auth/google/callback`. 

When the environment variables are all set, run the following command to start the app:

    source .env.dev && mix phx.server

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
