import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// To parse this JSON data, do
//
//     final bird = birdFromJson(jsonString);

import 'dart:convert';

Bird birdFromJson(String str) => Bird.fromJson(json.decode(str));

String? birdToJson(Bird data) => json.encode(data.toJson());

class Bird {
  Bird({
    this.id,
    this.englishName,
    this.family,
    this.redList,
    this.scientificName,
    this.spcRecId,
    this.photos,
    this.recordings,
    this.featuredImage,
  });

  String? id;
  String? englishName;
  String? family;
  String? redList;
  String? scientificName;
  int? spcRecId;
  List<Photo>? photos;
  List<Recording>? recordings;
  Photo? featuredImage;

  factory Bird.fromFire(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Bird.fromJson(data);
  }

  factory Bird.fromJson(Map<String, dynamic> json) => Bird(
        id: json["id"] == null ? null : json["id"],
        englishName: json["englishName"] == null ? null : json["englishName"],
        family: json["family"] == null ? null : json["family"],
        redList: json["redList"] == null ? null : json["redList"],
        scientificName:
            json["scientificName"] == null ? null : json["scientificName"],
        spcRecId: json["spcRecID"] == null ? null : json["spcRecID"],
        featuredImage: json["featuredImage"] == null
            ? null
            : Photo.fromJson(json["featuredImage"]),
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        recordings: json["recordings"] == null
            ? null
            : List<Recording>.from(
                json["recordings"].map((x) => Recording.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "englishName": englishName == null ? null : englishName,
        "family": family == null ? null : family,
        "redList": redList == null ? null : redList,
        "scientificName": scientificName == null ? null : scientificName,
        "spcRecID": spcRecId == null ? null : spcRecId,
        "featuredImage": featuredImage == null ? null : featuredImage!.toJson(),
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "recordings": recordings == null
            ? null
            : List<dynamic>.from(recordings!.map((x) => x.toJson())),
      };
}

class Photo {
  Photo({
    this.id,
    this.owner,
    this.secret,
    this.server,
    this.farm,
    this.title,
    this.ispublic,
    this.isfriend,
    this.isfamily,
  });

  String? id;
  String? owner;
  String? secret;
  String? server;
  int? farm;
  String? title;
  int? ispublic;
  int? isfriend;
  int? isfamily;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] == null ? null : json["id"],
        owner: json["owner"] == null ? null : json["owner"],
        secret: json["secret"] == null ? null : json["secret"],
        server: json["server"] == null ? null : json["server"],
        farm: json["farm"] == null ? null : json["farm"],
        title: json["title"] == null ? null : json["title"],
        ispublic: json["ispublic"] == null ? null : json["ispublic"],
        isfriend: json["isfriend"] == null ? null : json["isfriend"],
        isfamily: json["isfamily"] == null ? null : json["isfamily"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner": owner == null ? null : owner,
        "secret": secret == null ? null : secret,
        "server": server == null ? null : server,
        "farm": farm == null ? null : farm,
        "title": title == null ? null : title,
        "ispublic": ispublic == null ? null : ispublic,
        "isfriend": isfriend == null ? null : isfriend,
        "isfamily": isfamily == null ? null : isfamily,
      };
}

class Recording {
  Recording({
    this.id,
    this.gen,
    this.sp,
    this.ssp,
    this.en,
    this.rec,
    this.cnt,
    this.loc,
    this.lat,
    this.lng,
    this.alt,
    this.type,
    this.url,
    this.file,
    this.fileName,
    this.sono,
    this.lic,
    this.q,
    this.length,
    this.time,
    this.date,
    this.uploaded,
    this.also,
    this.rmk,
    this.birdSeen,
    this.playbackUsed,
  });

  String? id;
  String? gen;
  String? sp;
  String? ssp;
  String? en;
  String? rec;
  String? cnt;
  String? loc;
  String? lat;
  String? lng;
  String? alt;
  String? type;
  String? url;
  String? file;
  String? fileName;
  Sono? sono;
  String? lic;
  String? q;
  String? length;
  String? time;
  DateTime? date;
  DateTime? uploaded;
  List<String>? also;
  String? rmk;
  String? birdSeen;
  String? playbackUsed;

  factory Recording.fromJson(Map<String, dynamic> json) => Recording(
        id: json["id"] == null ? null : json["id"],
        gen: json["gen"] == null ? null : json["gen"],
        sp: json["sp"] == null ? null : json["sp"],
        ssp: json["ssp"] == null ? null : json["ssp"],
        en: json["en"] == null ? null : json["en"],
        rec: json["rec"] == null ? null : json["rec"],
        cnt: json["cnt"] == null ? null : json["cnt"],
        loc: json["loc"] == null ? null : json["loc"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
        alt: json["alt"] == null ? null : json["alt"],
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
        file: json["file"] == null ? null : json["file"],
        fileName: json["file-name"] == null ? null : json["file-name"],
        sono: json["sono"] == null ? null : Sono.fromJson(json["sono"]),
        lic: json["lic"] == null ? null : json["lic"],
        q: json["q"] == null ? null : json["q"],
        length: json["length"] == null ? null : json["length"],
        time: json["time"] == null ? null : json["time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        uploaded:
            json["uploaded"] == null ? null : DateTime.parse(json["uploaded"]),
        also: json["also"] == null
            ? null
            : List<String>.from(json["also"].map((x) => x)),
        rmk: json["rmk"] == null ? null : json["rmk"],
        birdSeen: json["bird-seen"] == null ? null : json["bird-seen"],
        playbackUsed:
            json["playback-used"] == null ? null : json["playback-used"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "gen": gen == null ? null : gen,
        "sp": sp == null ? null : sp,
        "ssp": ssp == null ? null : ssp,
        "en": en == null ? null : en,
        "rec": rec == null ? null : rec,
        "cnt": cnt == null ? null : cnt,
        "loc": loc == null ? null : loc,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "alt": alt == null ? null : alt,
        "type": type == null ? null : type,
        "url": url == null ? null : url,
        "file": file == null ? null : file,
        "file-name": fileName == null ? null : fileName,
        "sono": sono == null ? null : sono!.toJson(),
        "lic": lic == null ? null : lic,
        "q": q == null ? null : q,
        "length": length == null ? null : length,
        "time": time == null ? null : time,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "uploaded": uploaded == null
            ? null
            : "${uploaded!.year.toString().padLeft(4, '0')}-${uploaded!.month.toString().padLeft(2, '0')}-${uploaded!.day.toString().padLeft(2, '0')}",
        "also": also == null ? null : List<dynamic>.from(also!.map((x) => x)),
        "rmk": rmk == null ? null : rmk,
        "bird-seen": birdSeen == null ? null : birdSeen,
        "playback-used": playbackUsed == null ? null : playbackUsed,
      };
}

class Sono {
  Sono({
    this.small,
    this.med,
    this.large,
    this.full,
  });

  String? small;
  String? med;
  String? large;
  String? full;

  factory Sono.fromJson(Map<String, dynamic> json) => Sono(
        small: json["small"] == null ? null : json["small"],
        med: json["med"] == null ? null : json["med"],
        large: json["large"] == null ? null : json["large"],
        full: json["full"] == null ? null : json["full"],
      );

  Map<String, dynamic> toJson() => {
        "small": small == null ? null : small,
        "med": med == null ? null : med,
        "large": large == null ? null : large,
        "full": full == null ? null : full,
      };
}

/// Parse Flickr images to get static photo URL
extension Flickr on Photo {
  String url() => 'https://live.staticflickr.com/$server/${id}_${secret}_w.jpg';
}

/// Grab a photo to display as featured
///
/// Uses picture set by moderators as featured. Otherwise, uses the first
/// picture returned, ratings based on some magic.
extension Images on Bird {
  Photo? featurePhoto() {
    if (featuredImage != null) return featuredImage;
    if (photos == null || photos!.isEmpty) return null;
    return photos!.first;
  }
}
