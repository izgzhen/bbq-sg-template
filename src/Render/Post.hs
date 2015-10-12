module Render.Post (
  renderPost
) where

import Config
import BBQ.Task
import BBQ.Component.Post
import BBQ.Import

renderPost :: Render PostMeta PostSummary
renderPost = Render renderPostIndex renderPostPage

renderPostIndex PostSummary{..} = do
    need [$(templDirQ "post-index.hamlet")]
    let html = $(hamletFile $(templDirQ "post-index.hamlet")) ()
    return $ renderHtml html

renderPostPage PostSummary{..} PostMeta{..} = do
    need [$(templDirQ "post.hamlet")]
    let html = $(hamletFile $(templDirQ "post.hamlet")) ()
    return $ renderHtml html
