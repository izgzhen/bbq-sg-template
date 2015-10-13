module Render.Post (
  renderPost
) where

import Config
import BBQ.Task
import BBQ.Component.Post
import BBQ.Import
import BBQ.Route
import Text.Pandoc
import qualified Data.HashMap.Lazy as HM

renderPost :: Render PostMeta PostSummary
renderPost = Render renderPostIndex renderPostPage

renderPostIndex PostSummary{..} = do
    need [$(templDirQ "post-index.hamlet")]
    let m = HM.toList categories
    let html = $(hamletFile $(templDirQ "post-index.hamlet")) ()
    return $ renderHtml html

renderPostPage BuildConfig{..} PostSummary{..} PostMeta{..} = do
    need [$(templDirQ "post.hamlet")]
    let bodyHtml = writeHtml def
                        { writerReferenceLinks = True
                         , writerHtml5 = True
                         , writerHighlight = True }
                   $ body
    let jsSrc  = absolutePathNoEscape siteConfig ("/js/common.js" :: String)
    let cssSrc = absolutePathNoEscape siteConfig ("/css/common.css" :: String)
    let html = $(hamletFile $(templDirQ "post.hamlet")) ()
    return $ renderHtml html
