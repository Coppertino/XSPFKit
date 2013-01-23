//
//  XSPFReaderCallback.h
//  XSPFKit
//
//  Created by Ivan Ablamskyi on 22.01.13.
//  Copyright (c) 2013 Coppertino Inc. All rights reserved.
//

#include <Xspf.h>

@class XSPFPlaylist;

namespace Xspf {
    namespace XSPFKit {
        class XSPFReaderCallback: public XspfReaderCallback {
        private:
            bool valid;
            XSPFPlaylist *mPlaylist;
            
        public:
            XSPFReaderCallback(XSPFPlaylist *playlist);

        
        private:
            // XspfReaderCallback
            void addTrack(XspfTrack * track);
            void setProps(XspfProps * props);
            void notifySuccess();
            void notifyFatalError (int line, int column, int errorCode, XML_Char const *description);
            bool handleError(int line, int column, int errorCode, XML_Char const * description);
            bool handleWarning (int line, int column, int warningCode, XML_Char const *description);
        };
    }
}
