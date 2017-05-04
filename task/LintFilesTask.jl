module LintFilesTask
using Genie, Util, Lint, Logger

function description()
  """
  Lints the files in the indicated dir
  """
end

function run_task!()
  dir = joinpath(Pkg.dir("Genie"), "src")
  for filename in Task(() -> Util.walk_dir(dir))
    @show filename
    try
      lintfile(filename)
    catch ex
      Logger.log(ex)
    end
  end
end

end
