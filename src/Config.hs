module Config (
  myConfig
, templDirQ
) where

import Language.Haskell.TH
import BBQ.Config
import BBQ.Import 

myConfig = defaultBuildConfig {
    hsSrcDir = "BBQ",
    hsOther  = ["Main.hs", "Config.hs"],
    mdSrcDir = "post",
    wikiSrcDir = "wiki"
}

-- Used in Render compile time templates
templDirQ :: FilePath -> Q Exp
templDirQ s = [| "templates" </> s |]

