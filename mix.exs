defmodule Cldr.Territories.Mixfile do
  use Mix.Project

  @version "2.8.1"

  def project do
    [
      app: :ex_cldr_territories,
      version: @version,
      elixir: "~> 1.12",
      name: "Cldr Territories",
      source_url: "https://github.com/schultzer/cldr_territories",
      description: description(),
      package: package(),
      docs: docs(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      cldr_provider: {Cldr.Territory.Backend, :define_territory_module, []},
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  defp description do
    """
    Terrritory formatting functions for the Common Locale Data Repository (CLDR)
    package ex_cldr
    """
  end


  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      cldr_dep(),
      {:ex_doc, "~> 0.18", only: [:release, :dev]},
      {:jason, "~> 1.0", optional: true},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false, optional: true},
    ]
  end

  defp cldr_dep do
    cond do
      path = System.get_env("CLDR_PATH") -> {:ex_cldr, path: path}
      branch = System.get_env("BRANCH") -> {:ex_cldr, github: "elixir-cldr/cldr", branch: branch}
      true -> {:ex_cldr, git: "https://github.com/elixir-cldr/cldr.git"}
    end
  end

  defp package do
    [
      maintainers: ["Benjamin Schultzer"],
      licenses: ~w(MIT),
      links: links(),
      files: ~w(lib config mix.exs README* CHANGELOG* LICENSE*)
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      formatters: ["html"],
      extras: ["README.md", "CHANGELOG.md"]
    ]
  end

  def links do
    %{
      "GitHub"    => "https://github.com/schultzer/cldr_territories",
      "Readme"    => "https://github.com/schultzer/cldr_territories/blob/v#{@version}/README.md",
      "Changelog" => "https://github.com/schultzer/cldr_territories/blob/v#{@version}/CHANGELOG.md"
    }
  end

  defp elixirc_paths(:test), do: ~w(lib mix test)
  defp elixirc_paths(:dev), do: ~w(lib mix)
  defp elixirc_paths(_), do: ~w(lib)
end
