module Render.Index (
  indexResolver
) where

import Config
import BBQ.Import
import BBQ.Route
import BBQ.Config
import BBQ.Component.Post
import BBQ.Component.Wiki
import qualified Data.HashMap.Lazy as HM

indexResolver :: BuildConfig -> HashMap FilePath Text -> Maybe (Text, [FilePath])
indexResolver BuildConfig{..} widgetMap =
    let mPostWidget = HM.lookup "post/widget.json" widgetMap
        mWikiWidget = HM.lookup "wiki/widget.json" widgetMap
    in do
        postWidget <- mPostWidget
        wikiWidget <- mWikiWidget
        wks <- wikis <$> decode wikiWidget
        posts <- allPosts <$> decode postWidget
        let jsSrc  = absolutePathNoEscape siteConfig ("/js/common.js" :: String)
        let cssSrc = absolutePathNoEscape siteConfig ("/css/common.css" :: String)
        let html = $(hamletFile $(templDirQ "index.hamlet")) ()
        return (renderHtml html, [$(templDirQ "index.hamlet")])

