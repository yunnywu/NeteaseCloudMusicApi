import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import 'answer.dart';
import 'util/request.dart';
import 'util/utils.dart';

part 'module/album.dart';
part 'module/artist.dart';
part 'module/banner.dart';
part 'module/batch.dart';
part 'module/captch.dart';
part 'module/check_music.dart';
part 'module/comment.dart';
part 'module/daily_signin.dart';
part 'module/digitalAlbum_purchased.dart';
part 'module/dj.dart';
part 'module/event.dart';
part 'module/fm.dart';
part 'module/follow.dart';
part 'module/hot.dart';
part 'module/like.dart';
part 'module/login.dart';
part 'module/lyric.dart';
part 'module/msg.dart';
part 'module/mv.dart';
part 'module/personal.dart';
part 'module/playlist.dart';
part 'module/playmode.dart';
part 'module/recommend.dart';
part 'module/related.dart';
part 'module/resource_like.dart';
part 'module/search.dart';
part 'module/simi.dart';
part 'module/song.dart';
part 'module/top.dart';
part 'module/user.dart';
part 'module/video.dart';
part 'module/weblog.dart';

typedef Handler = Future<Answer> Function(Map query, List<Cookie> cookie);

final handles = <String, Handler>{
  "/album/newest": album_newest,
  "/album/sublist": album_sublist,
  "/album": album,
  "/artist/album": artist_album,
  "/artist/desc": artist_desc,
  "/artist/list": artist_list,
  "/artist/mv": artist_mv,
  "/artist/sub": artist_sub,
  "/artist/sublist": artist_sublist,
  "/artists": artists,
  "/banner": banner,
  "/batch": batch,
  "/captch/register": captch_register,
  "/captch/send": captch_send,
  "/captch/verify": captch_verify,
  "/comment/album": comment_album,
  "/comment/dj": comment_dj,
  "/comment/events": comment_events,
  "/comment/hot": comment_hot,
  "/comment/like": comment_like,
  "/comment/music": comment_music,
  "/comment/mv": comment_mv,
  "/comment/playlist": comment_playlist,
  "/comment/video": comment_video,
  "/comment": comment,
  "/daily_signin": daily_signin,
  "/digitalAlbum/purchased": digitalAlbum_purchased,
  "/dj/banner": dj_banner,
  "/dj/category/excludehot": dj_category_excludehot,
  "/dj/category/recommend": dj_category_recommend,
  "/dj/catelist": dj_catelist,
  "/dj/detail": dj_detail,
  "/dj/hot": dj_hot,
  "/dj/paygift": dj_paygift,
  "/dj/program/detail": dj_program_detail,
  "/dj/recommend/type": dj_recommend_type,
  "/dj/recommend": dj_recommend,
  "/dj/sub": dj_sub,
  "/dj/sublist": dj_sublist,
  "/dj/today/perfered": dj_today_perfered,
  "/event/del": event_del,
  "/event/forward": event_forward,
  "/event": event,
  "/fm_trash": fm_trash,
  "/follow": follow,
  "/hot_topic": hot_topic,
  "/like": like,
  "/likelist": likelist,
  "/login/cellphone": login_cellphone,
  "/login/refresh": login_refresh,
  "/login": login,
  "/logout": logout,
  "/lyric": lyric,
  "/msg/comment": msg_comment,
  "/msg/forwards": msg_forwards,
  "/msg/notice": msg_notice,
  "/msg/private/history": msg_private_history,
  "/msg/private": msg_private,
  "/mv/detail": mv_detail,
  "/mv/first": mv_first,
  "/mv/sub": mv_sub,
  "/mv/sublist": mv_sublist,
  "/personal_fm": personal_fm,
  "/personalized/djprogram": personalized_djprogram,
  "/personalized/mv": personalized_mv,
  "/personalized/newsong": personalized_newsong,
  "/personalized/privatecontent": personalized_privatecontent,
  "/personalized": personalized,
  "/playlist/catlist": playlist_catlist,
  "/playlist/create": playlist_create,
  "/playlist/detail": playlist_detail,
  "/playlist/hot": playlist_hot,
  "/playlist/subscribe": playlist_subscribe,
  "/playlist/subscribers": playlist_subscribers,
  "/playlist/tracks": playlist_tracks,
  "/playmode/intelligence/list": playmode_intelligence_list,
  "/program/recommend": program_recommend,
  "/recommend/resource": recommend_resource,
  "/recommend/songs": recommend_songs,
  "/related/allvideo": related_allvideo,
  "/related/playlist": related_playlist,
  "/resource/like": resource_like,
  "/search/hot": search_hot,
  "/search/multimatch": search_multimatch,
  "/search/suggest": search_suggest,
  "/search": search,
  "/simi/artist": simi_artist,
  "/simi/mv": simi_mv,
  "/simi/playlist": simi_playlist,
  "/simi/song": simi_song,
  "/simi/user": simi_user,
  "/song/detail": song_detail,
  "/song/url": song_url,
  "/top/album": top_album,
  "/top/artists": top_artists,
  "/top/list": top_list,
  "/top/mv": top_mv,
  "/top/playlist/highquality": top_playlist_highquality,
  "/top/playlist": top_playlist,
  "/top/song": top_song,
  "/toplist/artist": toplist_artist,
  "/toplist/detail": toplist_detail,
  "/toplist": toplist,
  "/user/audio": user_audio,
  "/user/cloud_del": user_cloud_del,
  "/user/cloud_detail": user_cloud_detail,
  "/user/cloud": user_cloud,
  "/user/detail": user_detail,
  "/user/dj": user_dj,
  "/user/event": user_event,
  "/user/followeds": user_followeds,
  "/user/follows": user_follows,
  "/user/playlist": user_playlist,
  "/user/record": user_record,
  "/user/subcount": user_subcount,
  "/user/update": user_update,
  "/video/detail": video_detail,
  "/video/group": video_group,
  "/video/sub": video_sub,
  "/video/url": video_url,
  "/weblog": weblog,
};
