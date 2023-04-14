import 'package:flutter/material.dart';

const BASEURL = "https://cathay.poket.com/cathay/";
const BASEURL1 = "https://cathay.poket.com/cathay/";

const SERVER_SUB_HEADER = "newapi/";

const LOGIN_URL =  "$BASEURL${SERVER_SUB_HEADER}BetimeConsumerLoginCmd";

const SIGNUP_URL =  "$BASEURL${SERVER_SUB_HEADER}ConsumerSignUpCmd";

const RESETPASSWORD_URL = "$BASEURL${SERVER_SUB_HEADER}ForgotPasswordCmd";

const PRIVACY_URL = "$BASEURL1${SERVER_SUB_HEADER}BetimePrivacyCmd";

const TERMS_AND_CONDITION_URL = "$BASEURL1${SERVER_SUB_HEADER}BetimeTermsCoditionsCmd";

const LOGOUT_URL ='$BASEURL${SERVER_SUB_HEADER}ConsumerLogoutCmd';

const PROFILE_URL ='$BASEURL${SERVER_SUB_HEADER}BetimeConsumerProfileCmd';
const FAQ_URL ='$BASEURL${SERVER_SUB_HEADER}/CathayFAQCmd';
const ABOUTUS_URL ='$BASEURL${SERVER_SUB_HEADER}/BetimeAboutUsCmd';
const HISTORY_LOG_URL = BASEURL+"consumer/CMAHistoryLogCmd";

const HOMEBANNERCMD ="$BASEURL${SERVER_SUB_HEADER}BetimeListBrowseBannersCmd" ;

const HOMEBANNERCMD_ITEM ="$BASEURL${SERVER_SUB_HEADER}BetimeItemListViewCmd" ;

const HOMEBANNERCMD_ITEM_DETAILS ="$BASEURL${SERVER_SUB_HEADER}BetimeItemDetailsCmdVersion1" ;

const PPN_URL ="$BASEURL${SERVER_SUB_HEADER}PPNCmdVersion1" ;

const INBOX_URL ='$BASEURL${SERVER_SUB_HEADER}InboxListCmdVersion3';

const INBOX_DETAILS_URL ='$BASEURL${SERVER_SUB_HEADER}InboxListDetailsCmdNewVersion3';

const REDEEMVOUCHER_URL = BASEURL + "tabletapplication/" + "RedeemVoucherThroughCMACmd";

const AccountDeletionUrl= BASEURL + SERVER_SUB_HEADER +"DeleteUserRequestCMD";

const WALLETPAGE_URL = BASEURL + SERVER_SUB_HEADER+ "CMAWalletSyncNewLayoutVersion1";

const FBPOSTSTATUSCMD = "";

const INBOX_DETAILS_URL1 =     BASEURL + SERVER_SUB_HEADER + 'showwebview/getWebView/';

const REWARDSLIST_URL ="$BASEURL${SERVER_SUB_HEADER}EastsideRewardCatalogVouchersCmdIOS" ;

const REWARDS_DETAIL_URL ="$BASEURL${SERVER_SUB_HEADER}/BetimeViewProgramDetailsCmd" ;

const REWARDS_DOWNLOAD_URL ="$BASEURL${SERVER_SUB_HEADER}PoketItCmdNewVersion4";

const MOBILE_NUMBER_VERIFICATION_URL = "$BASEURL${SERVER_SUB_HEADER}CathaySignupOTPCmd";

const GIFTPROGRAM_URL = "$BASEURL${SERVER_SUB_HEADER}GiftProgramCmd";

const SRORECEIPTHISTORY_URL = "$BASEURL${SERVER_SUB_HEADER}BetimeSROReceiptHistoryCmd";

const SRORECEIPTUPLOAD_URL = "$BASEURL${SERVER_SUB_HEADER}CathaySROUploadScanningReceiptCmd";

const SHOP_CATEGORY_URL = "$BASEURL${SERVER_SUB_HEADER}BetimeMYSroItemsCmdJson";
const BUYEVOUCHER_URL = BASEURL + SERVER_SUB_HEADER + "CathayeVoucherListViewCmd";
const ADDTOCARD_URL = BASEURL + SERVER_SUB_HEADER + "CathayeVoucherAddToCartCmd";
const CHECKOUT_CARD_URL = BASEURL + SERVER_SUB_HEADER + "CathayeVoucherCheckOutCartCmd";
const DELETEVOUCHER_URL = BASEURL + SERVER_SUB_HEADER + "CathayeVoucherDltFromCartCmd";
const PAYMENT_URL = BASEURL+"consumer/confirm_payment/";
const PARTICIPATINGOUTLETCMD ="$BASEURL${SERVER_SUB_HEADER}ParticipatingOutletsCmd" ;
const ShowUnreadCount_URL = "$BASEURL${SERVER_SUB_HEADER}showUnreadCountCmd" ;
