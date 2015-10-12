import BBQ.Import
import BBQ.Task
import BBQ.Component.Post
import BBQ.Component.Index
import BBQ.Component.Wiki
import BBQ.FTree
import Render.Post
import Render.Wiki
-- import qualified Data.HashMap.Lazy as HM

hsDeps :: FilePath -> Action ()
hsDeps srcDir = do
    hs <- getDirectoryFiles "" [ srcDir </> "/*.hs" ]
    need hs

main :: IO ()
main = do
    let config@BuildConfig{..} = defaultBuildConfig

    wikiPathTree <- mkFileTree "wiki"
    posts        <- mkFileTree "post" >>= (\(Dir _ trees) -> return $ filterFiles trees)
    shakeArgs shakeOptions { shakeFiles = targetDir } $ do
        let buildAt = (</>) targetDir
        phony "clean" $ removeFilesAfter targetDir ["//*"]

        want [buildAt wikiSrcDir </> "index.html"]
        want [buildAt mdSrcDir </> "index.html"]
        want [buildAt "index.html"]

        runRecTask targetDir wikiTask renderWiki wikiPathTree

        runTask postTask renderPost targetDir mdSrcDir posts []

        runCollectTask targetDir indexCollector
