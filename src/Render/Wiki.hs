module Render.Wiki (
  renderWiki
) where

import Config
import BBQ.Task
import BBQ.Component.Wiki
import BBQ.Import
import Text.Pandoc

renderWiki :: Render WikiMeta WikiSummary
renderWiki = Render renderWikiIndex renderWikiPage

renderWikiIndex WikiSummary{..} = do
    need [$(templDirQ "wiki-index.hamlet")]
    let html = $(hamletFile $(templDirQ "wiki-index.hamlet")) ()
    return $ renderHtml html

renderWikiPage BuildConfig{..} WikiSummary{..} WikiMeta{..} = do
    need [$(templDirQ "wiki.hamlet")]
    let bodyHtml = writeHtml def
                        {  writerReferenceLinks = True
                         , writerHtml5 = True
                         , writerHighlight = True }
                   $ body
    let jsSrc  = absolutePathNoEscape siteConfig ("/js/common.js" :: String)
    let cssSrc = absolutePathNoEscape siteConfig ("/css/common.css" :: String)
    let html = $(hamletFile $(templDirQ "wiki.hamlet")) ()
    return $ renderHtml html
