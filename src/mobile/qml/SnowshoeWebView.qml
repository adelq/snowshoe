/****************************************************************************
 *   Copyright (C) 2012  Instituto Nokia de Tecnologia (INdT)               *
 *                                                                          *
 *   This file may be used under the terms of the GNU Lesser                *
 *   General Public License version 2.1 as published by the Free Software   *
 *   Foundation and appearing in the file LICENSE.LGPL included in the      *
 *   packaging of this file.  Please review the following information to    *
 *   ensure the GNU Lesser General Public License version 2.1 requirements  *
 *   will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.   *
 *                                                                          *
 *   This program is distributed in the hope that it will be useful,        *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *   GNU Lesser General Public License for more details.                    *
 ****************************************************************************/

import QtQuick 2.0
import QtWebKit 3.0

import "UiConstants.js" as UiConstants

Item {
    id: webViewItem

    property variant tabNumber
    property alias url: webView.url
    property alias loading: webView.loading
    property alias canGoBack: webView.canGoBack
    property alias canGoForward: webView.canGoForward
    property variant statusIndicator
    property bool active: true
    property bool closeButtonVisible: false
    property bool interactive: true

    signal tabSelected(int tabNumber)
    signal closeTabRequested()

    function goBack() { webView.goBack() }
    function goForward() { webView.goForward() }
    function reload() { webView.reload() }
    function stop() { webView.stop() }

    WebView {
        id: webView
        anchors.fill: parent
        enabled: webViewItem.active && webViewItem.interactive

        onLoadingChanged: {
            if (loadRequest.status === WebView.LoadFailedStatus)
                webView.loadHtml(UiConstants.HtmlFor404Page)
        }
    }

    Image {
        id: borders
        visible: closeButton.visible
        anchors.left: parent.left
        anchors.leftMargin: -40
        source: ":/mobile/nav/border"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: !webViewItem.active
        onClicked: tabSelected(tabNumber)
    }

    Image {
        id: closeButton
        anchors.top: parent.top
        anchors.right: parent.right
        source: ":/mobile/nav/btn_close"
        visible: webViewItem.closeButtonVisible

        MouseArea {
            anchors.centerIn: parent
            height: parent.height * 0.7
            width: parent.width * 0.7
            onClicked: closeTabRequested()
        }
    }
}
