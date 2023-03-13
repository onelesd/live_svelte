import Config

if Mix.env() == :dev do
  esbuild = fn args ->
    [
      args: ~w(./js/live_svelte --bundle) ++ args,
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]
  end

  config :esbuild,
    version: "0.17.11",
    module: esbuild.(~w(--format=esm --sourcemap --outfile=../priv/static/live_svelte.esm.js)),
    main: esbuild.(~w(--format=cjs --sourcemap --outfile=../priv/static/live_svelte.cjs.js)),
    cdn: esbuild.(~w(--format=iife --target=es2016 --global-name=LiveView --outfile=../priv/static/live_svelte.js)),
    cdn_min: esbuild.(~w(--format=iife --target=es2016 --global-name=LiveView --minify --outfile=../priv/static/live_svelte.min.js))
end
