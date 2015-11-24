platform :ios, '8.0'

inhibit_all_warnings!

use_frameworks!

def app_pods
	pod 'Reachability'
	pod 'Masonry'
	pod 'BlocksKit'
	pod 'AFNetworking'
	pod 'SDWebImage'
	pod 'MBProgressHUD'
	pod 'MJRefresh'
    pod 'FlatUIKit'
    pod 'PINCache'
    pod 'FLEX'
    pod 'CocoaAsyncSocket'
    pod 'SSZipArchive'
    pod 'CocoaSecurity'
    pod 'BlockInjection'
end

def amap_pods
    pod 'AMap2DMap', '2.6.0'     #高德2D地图SDK
    pod 'AMapSearch', '2.6.0'     #高德地图搜索SDK
end

def tusdk_pods
    pod 'TuSDK'
end

def leancloud_pods
    pod 'AVOSCloud'
    pod 'AVOSCloudIM'
end

target 'Hackit' do
	app_pods
end

target 'Hackathon1024' do
	app_pods
    amap_pods
    tusdk_pods
    leancloud_pods
end