defmodule CowboyRoutesTree.Mixfile do
  use Mix.Project

  def project do
    [app: :cowboy_routes_tree,
     version: "0.2.0",
     description: description,
     package: package]
  end

  defp description do
    """
    Organize cowboy routes in trees.
    """
  end

  defp package do
    [maintainers: ["Ilya Khaprov"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/deadtrickster/cowboy_routes_tree"},
     files: ["src", "README.md", "LICENSE", "rebar.config"]]
  end
end
