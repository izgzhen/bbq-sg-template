module Render.Wiki (
  renderWiki
) where

import Config
import BBQ.Task
import BBQ.Component.Wiki
import BBQ.Import

renderWiki :: Render WikiMeta WikiSummary
renderWiki = Render renderWikiIndex renderWikiPage

renderWikiIndex WikiSummary{..} = do
    need [$(templDirQ "wiki-index.hamlet")]
    let html = $(hamletFile $(templDirQ "wiki-index.hamlet")) ()
    return $ renderHtml html

renderWikiPage WikiSummary{..} WikiMeta{..} = do
    need [$(templDirQ "wiki.hamlet")]
    let html = $(hamletFile $(templDirQ "wiki.hamlet")) ()
    return $ renderHtml html
