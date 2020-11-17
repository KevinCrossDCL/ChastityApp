
#option_explicit

SetErrorMode(2)

SetWindowTitle("OryUI Framework")
SetWindowAllowResize(1)
SetOrientationAllowed(1, 1, 1, 1)
SetSyncRate(60, 0)
SetScissor(0, 0, 0, 0)
UseNewDefaultFonts(1)

#insert "..\OryUI Framework\OryUI.agc"
#insert "..\OryUI Framework\OryUIButton.agc"
#insert "..\OryUI Framework\OryUIButtonGroup.agc"
#insert "..\OryUI Framework\OryUIDialog.agc"
#insert "..\OryUI Framework\OryUIEditAvatarScreen.agc"
#insert "..\OryUI Framework\OryUIFloatingActionButton.agc"
#insert "..\OryUI Framework\OryUIHTTPSQueue.agc"
#insert "..\OryUI Framework\OryUIInputSpinner.agc"
#insert "..\OryUI Framework\OryUIList.agc"
#insert "..\OryUI Framework\OryUIMedia.agc"
#insert "..\OryUI Framework\OryUIMenu.agc"
#insert "..\OryUI Framework\OryUINavigationDrawer.agc"
#insert "..\OryUI Framework\OryUIPagination.agc"
#insert "..\OryUI Framework\OryUIProgressIndicator.agc"
#insert "..\OryUI Framework\OryUIScrollBar.agc"
#insert "..\OryUI Framework\OryUIScrollToTop.agc"
#insert "..\OryUI Framework\OryUISprite.agc"
#insert "..\OryUI Framework\OryUITabs.agc"
#insert "..\OryUI Framework\OryUIText.agc"
#insert "..\OryUI Framework\OryUITextCard.agc"
#insert "..\OryUI Framework\OryUITextfield.agc"
#insert "..\OryUI Framework\OryUITooltip.agc"
#insert "..\OryUI Framework\OryUITopBar.agc"
#insert "..\OryUI Framework\OryUITouch.agc"
#insert "..\OryUI Framework\OryUIDefaultSettings.agc"

do
	OryUIStartTrackingTouch()

	OryUIEndTrackingTouch()
	
	Sync()
loop
