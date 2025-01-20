#!/usr/bin/env bash
###
# @Author: Cloudflying
# @Date: 2023-04-05 12:51:00
# @LastEditTime: 2025-01-20 00:21:18
# @LastEditors: Cloudflying
# @Description: Fetch Filters
###

# Github Action Set Asia/Shanghai Timezone
export TZ='Asia/Shanghai'

ROOT_PATH=$(dirname $(dirname $(realpath $0)))
FILTERS_PATH=${ROOT_PATH}/storage/filters
DATE=$(date "+%Y-%m-%d")

mkdir -p ${FILTERS_PATH}/{advert,annoyance,cookie,features,fonts,friendly,hosts,mobile,miner,notifications,privacy,security,social,tracking,video}

cd ${FILTERS_PATH}

_get()
{
  URL=$1
  FILE=$2
  echo "Fetching $FILE"
  # axel -n 16 -c -k -a -U "Mozilla/5.0" $@
  if [[ ! -f $FILE ]]; then
    wget -c $URL -O $FILE
  fi
}

function advert()
{
  cd ${FILTERS_PATH}/advert
  # EasyList (反广告主规则列表。主要面向英文网站，包含大量通用规则)
  # EasyList 是主要的过滤列表，可从国际网页中删除大多数广告，包括不需要的框架、图片和对象。它是许多广告拦截器使用的最流行的列表，并构成了十多个组合和补充过滤列表的基础。
  # https://easylist-downloads.adblockplus.org/easylist.txt
  # https://secure.fanboy.co.nz/easylist.txt
  # _get https://ublockorigin.pages.dev/thirdparties/easylist.txt easylist-${DATE}.txt
  _get https://easylist.to/easylist/easylist.txt easylist-${DATE}.txt

  # EasyList China : 国内网站广告过滤的主规则 (反广告主规则列表的补充。主要面向中文网站)
  # https://easylist-downloads.adblockplus.org/easylistchina.txt
  _get https://raw.githubusercontent.com/easylist/easylistchina/master/easylistchina.txt easylist-easylistchina-${DATE}.txt

  _get https://ublockorigin.pages.dev/filters/filters.txt ubo-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/filters-2020.txt ubo-2020-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/filters-2021.txt ubo-2021-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/filters-2022.txt ubo-2022-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/filters-2023.txt ubo-2023-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/quick-fixes.txt ubo-fixes-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/ubol-filters.txt ubo-ubol-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/unbreak.txt ubo-unbreak-${DATE}.txt
  _get https://ublockorigin.pages.dev/filters/lan-block.txt ubo-lan-block-${DATE}.txt
  _get https://ublockorigin.pages.dev/thirdparties/easylist-newsletters.txt easylist-newsletters-${DATE}.txt

  # Brave
  _get https://raw.githubusercontent.com/brave/adblock-lists/master/brave-lists/brave-specific.txt brave-specific-${DATE}.txt
  _get https://raw.githubusercontent.com/brave/adblock-lists/master/brave-lists/brave-firstparty.txt brave-firstparty-${DATE}.txt
  _get https://raw.githubusercontent.com/brave/adblock-lists/master/brave-unbreak.txt brave-unbreak-${DATE}.txt

  # AdGuard Base filter
  # EasyList + AdGuard English filter. This filter is necessary for quality ad blocking.
  _get https://filters.adtidy.org/extension/chromium/filters/2.txt adguard-base-${DATE}.txt
  # AdGuard Experimental filter
  # Filter designed to test certain hazardous filtering rules before they are added to the basic filters.
  _get https://filters.adtidy.org/extension/chromium/filters/5.txt adguard-experimental-${DATE}.txt

  # AdGuard Popups filter
  # Blocks all kinds of pop-ups that are not necessary for websites' operation according to our Filter policy.
  _get https://filters.adtidy.org/extension/chromium/filters/19.txt adguard-popups-${DATE}.txt

  # AdGuard Chinese filter
  # EasyList China + AdGuard Chinese filter. Filter list that specifically removes ads on websites in Chinese language.
  _get https://filters.adtidy.org/extension/chromium/filters/224.txt adguard-chinese-${DATE}.txt

  # X浏览器拦截规则国内版本
  _get https://raw.githubusercontent.com/examplecode/ad-rules-for-xbrowser/master/core-rule-cn.txt xbrowser-${DATE}.txt
  _get https://raw.githubusercontent.com/8680/GOODBYEADS/master/data/rules/adblock.txt goodbeyads-adblock-${DATE}.txt
  # 混合
  _get https://raw.githubusercontent.com/lingeringsound/adblock_auto/main/Rules/adblock_auto.txt adblock-auto-${DATE}.txt
  _get https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdns.txt adblockfilters-${DATE}.txt
  _get https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_plus.txt uniartisan-${DATE}.txt
  _get https://raw.githubusercontent.com/Cats-Team/AdRules/main/adblock_plus.txt cats-team-${DATE}.txt
  _get https://raw.githubusercontent.com/yokoffing/filterlists/refs/heads/main/youtube_clear_view.txt yokoffing-youtube-${DATE}.txt
  _get https://raw.githubusercontent.com/abpvn/abpvn/refs/heads/master/filter/abpvn_adguard.txt abpvn-${DATE}.txt
  _get https://raw.githubusercontent.com/Xaival/AdBlockList/main/Adblock_list.txt xaival-${DATE}.txt
  _get https://easylist-downloads.adblockplus.org/global-filters.txt global-filters-${DATE}.txt
  _get https://raw.githubusercontent.com/reek/anti-adblock-killer/master/anti-adblock-killer-filters.txt anti-adblock-killer-filters-${DATE}.txt

  # 基于 EasyList 和 AdGuard 的英文广告过滤器
  _get https://filters.adavoid.org/ultimate-ad-filter.txt ultimate-ad-${DATE}.txt

  # Adblock Warning Removal List 删除反广告拦截警告和其他干扰性消息
  # Removes anti-adblock warnings and other obtrusive messages.
  _get https://easylist-downloads.adblockplus.org/antiadblockfilters.txt easylist-antiad-${DATE}.txt

  # 乘风通用过滤规则，适用于UBO或ADG扩展。ADG for PC 不支持 scriptlet规则
  _get https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt sf-rules-${DATE}.txt

  # Anti-circumvention/反规避 打击规避广告
  _get https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt anti-cv-${DATE}.txt

  # AdGuard（匹配整个URL的域名部分）
  # 屏蔽广告域名，能屏蔽电视盒子广告，屏蔽 App 内置广告，同时屏蔽了一些日志收集、大数据统计等涉及个人隐私信息的站点，能够保护个人隐私不被偷偷上传
  # https://anti-ad.net/adguard.txt
  _get https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt anti-ad-adguard-${DATE}.txt

  # 适用于 x浏览器 的去广告规则（兼容大部分浏览器和AdGuard客户端和AdGuard与uBlock Origin浏览器扩展) 主要去除色情悬浮广告 对 不是涩情网站
  _get https://raw.githubusercontent.com/damengzhu/banad/refs/heads/main/jiekouAD.txt damengzhu-${DATE}.txt
}

function annoyance()
{
  cd ${FILTERS_PATH}/annoyance
  # AdGuard Annoyances filter
  _get https://filters.adtidy.org/extension/chromium/filters/14.txt adguard-annoyances-${DATE}.txt

  # AdGuard Other Annoyances filter
  # Blocks irritating elements on web pages that do not fall under the popular categories of annoyances.
  _get https://filters.adtidy.org/extension/chromium/filters/21.txt adguard-other-annoyances-${DATE}.txt

  _get https://raw.githubusercontent.com/yokoffing/filterlists/refs/heads/main/annoyance_list.txt yokoffing-annoyance-${DATE}.txt
  _get https://ublockorigin.github.io/uAssets/thirdparties/easylist-chat.txt easylist-chat-annoyance-${DATE}.txt

  # Annoyances
  _get https://ublockorigin.pages.dev/filters/annoyances.txt ubo-annoyances-${DATE}.txt

  # 阻止所有烦人的页面内弹出窗口、cookie 通知和第三方小部件 慎用 会导致页面功能不正常 或单独放置
  # Fanboy’s Annoyances List
  # https://ublockorigin.pages.dev/thirdparties/easylist-annoyances.txt
  _get https://easylist.to/easylist/fanboy-annoyance.txt easylist-fanboy-annoyance-${DATE}.txt
  # Fanboy 的烦人列表会阻止社交媒体内容、页面内弹出窗口和其他烦人内容；从而大幅减少网页加载时间并使其变得整洁。EasyList Cookie 列表和 Fanboy 的社交阻止列表已包含在内
  # https://fanboy.co.nz/fanboy-annoyance.txt
  _get https://secure.fanboy.co.nz/fanboy-annoyance.txt fanboy-annoyance-${DATE}.txt
  # 删除页面内弹出窗口和其他烦恼。包括 Fanboy 的社交屏蔽和 EasyList Cookie 列表
  # _get https://secure.fanboy.co.nz/fanboy-annoyance_ubo.txt fanboy-annoyance-ubo-${DATE}.txt

  # 阻止网页上不属于流行的烦恼类别的刺激性元素。
  _get https://filters.adtidy.org/extension/chromium/filters/21.txt adguard-annoyances-other-${DATE}.txt

  _get https://raw.githubusercontent.com/abp-filters/abp-filters-compliance/main/fanboyannoyances.txt abp-fanboy-annoyances-${DATE}.txt
  # 修复和删除恼人的网页元素，例如粘性标题、浮动框、浮动视频、dickbars、社交分享栏和其他分散注意力的元素。
  _get https://raw.githubusercontent.com/yourduskquibbles/webannoyances/master/ultralist.txt webannoyances-${DATE}.txt

  # CJX's Annoyance List (反自我推广,移除anti adblock,防跟踪规则列表) 是"EasyList China+EasyList" & "EasyPrivacy"的补充 移除anti adblock
  # https://main.filter-delivery-staging.eyeo.com/v3/full/cjx-annoyance.txt
  # https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt
  _get https://filters.adtidy.org/extension/chromium/filters/220.txt cjx-annoyance-${DATE}.txt
}

## Cookie
function cookie()
{
  cd ${FILTERS_PATH}/cookie
  # 慎用 可能会造成不可预知的页面功能错误
  # I don't care about cookies : 我不关心 Cookie 的问题，隐藏来自几乎所有网站的烦人的 cookie 警告，并避免不必要的点击。
  # _get https://www.i-dont-care-about-cookies.eu/abp/ i-dont-care-about-cookies-${DATE}.txt
  _get https://easylist-downloads.adblockplus.org/i_dont_care_about_cookies.txt i-dont-care-about-cookies-${DATE}.txt
  # 删除 cookie 和隐私警告。已经包含在 Fanboy 的烦恼列表中。
  # EasyList Cookie 列表会阻止 cookie 横幅、GDPR 覆盖窗口和其他与隐私相关的通知。
  _get https://secure.fanboy.co.nz/fanboy-cookiemonster.txt fanboy-cookiemonster-${DATE}.txt
  _get https://raw.githubusercontent.com/brave/adblock-lists/refs/heads/master/brave-lists/brave-cookie-specific.txt brave-cookie-${DATE}.txt
  # AdGuard Cookie Notices filter: Blocks cookie notices on web pages.
  _get https://filters.adtidy.org/extension/chromium/filters/18.txt adguard-cookie-${DATE}.txt
  _get https://ublockorigin.pages.dev/thirdparties/easylist-cookies.txt easylist-cookies-${DATE}.txt
}

function features()
{
  cd ${FILTERS_PATH}/features
  # Browse websites without logging in
  _get https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/BrowseWebsitesWithoutLoggingIn.txt browser-without-login-${DATE}.txt
}

function fonts()
{
  cd ${FILTERS_PATH}/fonts
  # 阻止第三方字体的过滤器。它可能会破坏某些网站的外观和设计
  _get https://fanboy.co.nz/fanboy-antifonts.txt fanboy-antifonts-${DATE}.txt
  _get https://raw.githubusercontent.com/yokoffing/filterlists/refs/heads/main/block_third_party_fonts.txt yokoffing-antifonts-${DATE}.txt
}

function friendly()
{
  cd ${FILTERS_PATH}/friendly
  _get https://easylist-downloads.adblockplus.org/exceptionrules-privacy-friendly.txt privacy-friendly-${DATE}.txt
}

function hosts()
{
  cd ${FILTERS_PATH}/hosts
  # Advert
  # Hosts 类型广告屏蔽
  # 过滤器由多个其他过滤器（AdGuard Base 过滤器、社交媒体过滤器、跟踪保护过滤器、移动广告过滤器、EasyList 和 EasyPrivacy）组成，并经过专门简化以更好地与 DNS 级广告拦截兼容

  # 阻止广告、跟踪器、恶意软件和其他垃圾
  _get https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Formats/GoodbyeAds-AdBlock-Filter.txt goodbeyads-adblock-${DATE}.txt
  _get https://raw.githubusercontent.com/notracking/hosts-blocklists/master/adblock/adblock.txt notracking-blocklists-${DATE}.txt
  _get https://hblock.molinero.dev/hosts_adblock.txt hblock-${DATE}.txt
  # 过滤广告、跟踪器和其他讨厌的东西
  # _get "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&mimetype=plaintext" peter-lowes-${DATE}.txt
  _get "https://filters.adtidy.org/extension/chromium/filters/204.txt" peter-lowes-${DATE}.txt

  # AdGuard CNAME disguised trackers list
  _get https://raw.githubusercontent.com/8680/GOODBYEADS/master/data/rules/dns.txt goodbyeads-dns-${DATE}.txt
  _get https://raw.githubusercontent.com/neodevpro/neodevhost/master/adblocker neodevhost-hosts-${DATE}.txt
  _get https://raw.githubusercontent.com/Cats-Team/AdRules/main/dns.txt cats-team-hosts-${DATE}.txt
  _get https://raw.githubusercontent.com/DoingDog/rconvert/main/a1/fin-adb.txt doingdog-hosts-${DATE}.txt
  # 诈骗、网络钓鱼和恶意软件域的黑名单
  _get https://raw.githubusercontent.com/jarelllama/Scam-Blocklist/main/lists/adblock/scams.txt jarelllama-hosts-${DATE}.txt
  _get https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt hagezi-hosts-${DATE}.txt
  _get https://raw.githubusercontent.com/lingeringsound/10007/main/adb.txt lingeringsound-hosts-${DATE}.txt
  _get https://abpvn.com/android/abpvn.txt abpvn-android-hosts-${DATE}.txt

  # AdGuard DNS filter
  # Filter composed of several other filters (AdGuard Base filter, Social Media filter, Tracking Protection filter, Mobile Ads filter, EasyList and EasyPrivacy) and simplified specifically to be better compatible with DNS-level ad blocking.
  _get https://filters.adtidy.org/extension/chromium/filters/15.txt adguard-dns-${DATE}.txt

  _get https://raw.githubusercontent.com/damengzhu/banad/main/hosts.txt damengzhu-${DATE}.txt
}

function mobile()
{
  cd ${FILTERS_PATH}/mobile
  _get https://raw.githubusercontent.com/brave/adblock-lists/refs/heads/master/brave-lists/brave-ios-specific.txt brave-ios-${DATE}.txt
  _get https://raw.githubusercontent.com/BlackJack8/iOSAdblockList/refs/heads/master/Hosts.txt ios-hosts-${DATE}.txt
  _get https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_lite.txt uniartisan-mobile-${DATE}.txt

  # AdGuard Mobile Ads filter 过滤所有已知的移动广告网络。对移动设备很有用。
  _get https://filters.adtidy.org/extension/chromium/filters/11.txt adguard-mobile-${DATE}.txt
  # 阻止宣传网站移动应用程序的烦人横幅
  # AdGuard Mobile App Banners filter
  # Blocks irritating banners that promote mobile apps of websites.
  _get https://filters.adtidy.org/extension/chromium/filters/20.txt adguard-mobile-banners-${DATE}.txt

  # adgk手机去广告规则
  _get https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt adgk-${DATE}.txt
}

# Miner
function miner()
{
  cd ${FILTERS_PATH}/miner

  # filters browser based miners such as coin-hive
  _get https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt nocoin-${DATE}.txt
  _get https://filters.adavoid.org/filters/NoCoin.txt adavoid-nocoin-${DATE}.txt
}

# Notification blocking
function notifications()
{
  cd ${FILTERS_PATH}/notifications
  # Fanboy's Notifications Blocking List
  # https://ublockorigin.pages.dev/thirdparties/easylist-notifications.txt
  _get https://easylist-downloads.adblockplus.org/fanboy-notifications.txt fanboy-notifications-${DATE}.txt

  # AdGuard Cookie Notices filter
  # Blocks cookie notices on web pages.
  _get https://filters.adtidy.org/extension/chromium/filters/18.txt adguard-cookie-notices-${DATE}.txt
}

## Privacy Protection
function privacy()
{
  cd ${FILTERS_PATH}/privacy

  # CJX's uBlock list (CJX's Annoyance List的补充 ubo专用)
  # "EasyList China+EasyList" & "EasyPrivacy" & "CJX's Annoyance List"的补充
  _get https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-ublock.txt cjx-ublock-${DATE}.txt

  _get https://ublockorigin.pages.dev/filters/privacy.txt ubo-privacy-${DATE}.txt
  # EasyPrivacy 防隐私跟踪挖矿规则列表
  # EasyPrivacy 是一个可选的补充过滤列表，可以彻底删除互联网上所有形式的跟踪，包括网络臭虫、跟踪脚本和信息收集器，从而保护您的个人数据。
  # https://easylist.to/easylist/easyprivacy.txt
  _get https://easylist-downloads.adblockplus.org/easyprivacy.txt easylist-easyprivacy-${DATE}.txt
  _get https://client.admon.app/admon-privacy.txt admon-privacy-${DATE}.txt
  # 阻止各种在线跟踪器、计数器和网络分析工具的广泛列表。基于 EasyList
  _get https://filters.adavoid.org/ultimate-privacy-filter.txt ultimate-privacy-${DATE}.txt
  # Search Engine
  # 解锁搜索（Duckduckgo、谷歌、必应、雅虎）和自我宣传广告的过滤器。自我宣传定义：当网站上的广告宣传该网站或与之密切相关的其他网站/社交媒体等时，此类广告被视为自我宣传广告。
  _get https://filters.adtidy.org/extension/chromium/filters/10.txt adguard-search-${DATE}.txt
  # 阻止烦人的第三方小部件：在线助手、实时支持聊天等。
  # AdGuard Widgets filter
  # Blocks annoying third-party widgets: online assistants, live support chats, etc.
  _get https://filters.adtidy.org/extension/chromium/filters/22.txt adguard-widgets-${DATE}.txt
  _get https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_privacy.txt uniartisan-privacy-${DATE}.txt
  _get https://raw.githubusercontent.com/yokoffing/filterlists/refs/heads/main/privacy_essentials.txt yokoffing-privacy-${DATE}.txt
}

# Security
function security()
{
  cd ${FILTERS_PATH}/security
  # Badware risks
  _get https://ublockorigin.pages.dev/filters/badware.txt ubo-badware-${DATE}.txt

  # 阻止恶意域。基于在线恶意域黑名单过滤器
  # AdBlocker Ultimate Security Filter is a filter list that blocks malicious websites, phishing sites, malware, and other online threats.
  _get https://filters.adavoid.org/ultimate-security-filter.txt ultimate-security-${DATE}.txt

  # Malware protection/恶意软件保护
  # 资源滥用 如 CPU 带宽等
  _get https://ublockorigin.pages.dev/filters/resource-abuse.txt ubo-resource-abuse-${DATE}.txt

  # - Online Malicious URL Blocklist 在线恶意网址 如挂马附件 代码 图片等
  # - https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/thirdparties/urlhaus-filter/urlhaus-filter-online.txt

  # CPBL Filters for Adblock Plus (Mini)
  # removes ads, trackers/telemetry, malware and scams
  _get https://raw.githubusercontent.com/bongochong/CombinedPrivacyBlockLists/master/cpbl-abp-list.txt abp-cpbl-${DATE}.txt

  # 网络钓鱼
  _get https://raw.githubusercontent.com/curbengh/phishing-filter/gh-pages/phishing-filter-ag.txt malware-phishing-${DATE}.txt
  # 恶意域阻止列表
  # https://raw.githubusercontent.com/curbengh/vn-badsite-filter/gh-pages/vn-badsite-filter-ag.txt
  _get https://curbengh.github.io/malware-filter/vn-badsite-filter-ag.txt malware-badsite-${DATE}.txt
  # 僵尸网络 Botnet IP
  # https://raw.githubusercontent.com/curbengh/botnet-filter/gh-pages/botnet-filter-ag.txt
  _get https://curbengh.github.io/malware-filter/botnet-filter-ag.txt malware-botnet-${DATE}.txt
  _get https://curbengh.github.io/malware-filter/urlhaus-filter-agh-online.txt urlhaus-filter-agh-online-${DATE}.txt

  # 阻止恶意URL 已知用于传播恶意软件和间谍软件的域
  # Online Malicious URL Blocklist
  # Blocks domains that are known to be used to propagate malware and spyware.
  # https://urlhaus-filter.pages.dev/urlhaus-filter-ag-online.txt
  _get https://curbengh.github.io/malware-filter/urlhaus-filter-ag.txt malware-urlhaus-${DATE}.txt
  _get https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt malware-spam404-${DATE}.txt

  # https://curbengh.github.io/malware-filter/phishing-filter-agh.txt
  # Phishing URL Blocklist
  # Phishing URL blocklist for uBlock Origin (uBO), AdGuard, Vivaldi, Pi-hole, Hosts file, Dnsmasq, BIND, Unbound, Snort and Suricata.
  _get https://malware-filter.gitlab.io/malware-filter/phishing-filter-ag.txt malware-filter-phishing-${DATE}.txt
}

function social()
{
  cd ${FILTERS_PATH}/social
  # Social
  # Fanboy's Social Blocking List
  # https://easylist-downloads.adblockplus.org/fanboy-social.txt
  # 删除社交媒体集成
  # Fanboy 的社交阻止列表仅删除网页上的社交媒体内容，例如 Facebook 点赞按钮和其他小部件。
  # https://ublockorigin.pages.dev/thirdparties/easylist-social.txt
  _get https://easylist.to/easylist/fanboy-social.txt easylist-fanboy-social-${DATE}.txt

  # 会破坏某些网站上基于 Facebook 的评论，也可能会破坏某些 Facebook 应用程序或游戏。
  _get https://fanboy.co.nz/fanboy-antifacebook.txt fanboy-antifacebook-${DATE}.txt
  _get https://filters.adavoid.org/filters/FanboysSocialBlockingList.txt adavoid-FanboysSocialBlockingList-${DATE}.txt
  _get https://raw.githubusercontent.com/brave/adblock-lists/master/brave-lists/brave-social.txt brave-social-${DATE}.txt
  _get https://raw.githubusercontent.com/abp-filters/abp-filters-anti-cv/master/fb_non-graph.txt abp-facebook-non-graph-${DATE}.txt
  # 过滤社交媒体小部件，例如“喜欢”和“分享”按钮等。
  # AdGuard Social Media filter
  # Filter for social media widgets such as 'Like' and 'Share' buttons and more.
  _get https://filters.adtidy.org/extension/chromium/filters/4.txt adguard-social-${DATE}.txt
}

# Tracking
function tracking()
{
  cd ${FILTERS_PATH}/tracking

  # AdGuard Tracking Protection filter 在线计数器和网络分析工具屏蔽
  # The most comprehensive list of various online counters and web analytics tools. Use this filter if you do not want your actions on the Internet to be tracked.
  _get https://filters.adtidy.org/extension/chromium/filters/3.txt adguard-tracking-${DATE}.txt
  # AdGuard URL Tracking filter
  # Filter that enhances privacy by removing tracking parameters from URLs.
  _get https://filters.adtidy.org/extension/chromium/filters/17.txt adguard-url-tracking-${DATE}.txt

  # JS 跟踪阻止列表 / Tracking JS Blocklist
  _get https://curbengh.github.io/malware-filter/tracking-filter.txt malware-tracking-${DATE}.txt
}

# Video
function video()
{
  cd ${FILTERS_PATH}/video
  # 乘风视频过滤规则，适用于UBO或ADG扩展
  _get https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt sf-mv-${DATE}.txt
  _get https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/minority-mv.txt sf-minority-mv-${DATE}.txt
  # 这个不太对 似乎是全屏蔽了
  # _get https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Formats/GoodbyeAds-YouTube-AdBlock-Filter.txt youtube-${DATE}.txt
}

advert
annoyance
# audit
cookie
features
fonts
friendly
# hosts
mobile
miner
notifications
privacy
security
social
tracking
video
