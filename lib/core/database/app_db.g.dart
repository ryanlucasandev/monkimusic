// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $SongsTableTable extends SongsTable
    with TableInfo<$SongsTableTable, SongsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<int> songId = GeneratedColumn<int>(
    'song_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
    'album',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumIdMeta = const VerificationMeta(
    'albumId',
  );
  @override
  late final GeneratedColumn<int> albumId = GeneratedColumn<int>(
    'album_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistIdMeta = const VerificationMeta(
    'artistId',
  );
  @override
  late final GeneratedColumn<int> artistId = GeneratedColumn<int>(
    'artist_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackMeta = const VerificationMeta('track');
  @override
  late final GeneratedColumn<int> track = GeneratedColumn<int>(
    'track',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
    'genre',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateAddedMeta = const VerificationMeta(
    'dateAdded',
  );
  @override
  late final GeneratedColumn<int> dateAdded = GeneratedColumn<int>(
    'date_added',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    songId,
    id,
    filePath,
    title,
    artist,
    album,
    albumId,
    artistId,
    duration,
    track,
    genre,
    dateAdded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'songs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SongsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(
        _songIdMeta,
        songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    }
    if (data.containsKey('album')) {
      context.handle(
        _albumMeta,
        album.isAcceptableOrUnknown(data['album']!, _albumMeta),
      );
    }
    if (data.containsKey('album_id')) {
      context.handle(
        _albumIdMeta,
        albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta),
      );
    }
    if (data.containsKey('artist_id')) {
      context.handle(
        _artistIdMeta,
        artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('track')) {
      context.handle(
        _trackMeta,
        track.isAcceptableOrUnknown(data['track']!, _trackMeta),
      );
    }
    if (data.containsKey('genre')) {
      context.handle(
        _genreMeta,
        genre.isAcceptableOrUnknown(data['genre']!, _genreMeta),
      );
    }
    if (data.containsKey('date_added')) {
      context.handle(
        _dateAddedMeta,
        dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  SongsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SongsTableData(
      songId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}song_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      ),
      album: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album'],
      ),
      albumId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}album_id'],
      ),
      artistId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}artist_id'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      track: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track'],
      ),
      genre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre'],
      ),
      dateAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_added'],
      ),
    );
  }

  @override
  $SongsTableTable createAlias(String alias) {
    return $SongsTableTable(attachedDatabase, alias);
  }
}

class SongsTableData extends DataClass implements Insertable<SongsTableData> {
  final int songId;
  final String id;
  final String filePath;
  final String? title;
  final String? artist;
  final String? album;
  final int? albumId;
  final int? artistId;
  final int? duration;
  final int? track;
  final String? genre;
  final int? dateAdded;
  const SongsTableData({
    required this.songId,
    required this.id,
    required this.filePath,
    this.title,
    this.artist,
    this.album,
    this.albumId,
    this.artistId,
    this.duration,
    this.track,
    this.genre,
    this.dateAdded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<int>(songId);
    map['id'] = Variable<String>(id);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || album != null) {
      map['album'] = Variable<String>(album);
    }
    if (!nullToAbsent || albumId != null) {
      map['album_id'] = Variable<int>(albumId);
    }
    if (!nullToAbsent || artistId != null) {
      map['artist_id'] = Variable<int>(artistId);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || track != null) {
      map['track'] = Variable<int>(track);
    }
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    if (!nullToAbsent || dateAdded != null) {
      map['date_added'] = Variable<int>(dateAdded);
    }
    return map;
  }

  SongsTableCompanion toCompanion(bool nullToAbsent) {
    return SongsTableCompanion(
      songId: Value(songId),
      id: Value(id),
      filePath: Value(filePath),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      artist: artist == null && nullToAbsent
          ? const Value.absent()
          : Value(artist),
      album: album == null && nullToAbsent
          ? const Value.absent()
          : Value(album),
      albumId: albumId == null && nullToAbsent
          ? const Value.absent()
          : Value(albumId),
      artistId: artistId == null && nullToAbsent
          ? const Value.absent()
          : Value(artistId),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      track: track == null && nullToAbsent
          ? const Value.absent()
          : Value(track),
      genre: genre == null && nullToAbsent
          ? const Value.absent()
          : Value(genre),
      dateAdded: dateAdded == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAdded),
    );
  }

  factory SongsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SongsTableData(
      songId: serializer.fromJson<int>(json['songId']),
      id: serializer.fromJson<String>(json['id']),
      filePath: serializer.fromJson<String>(json['filePath']),
      title: serializer.fromJson<String?>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
      album: serializer.fromJson<String?>(json['album']),
      albumId: serializer.fromJson<int?>(json['albumId']),
      artistId: serializer.fromJson<int?>(json['artistId']),
      duration: serializer.fromJson<int?>(json['duration']),
      track: serializer.fromJson<int?>(json['track']),
      genre: serializer.fromJson<String?>(json['genre']),
      dateAdded: serializer.fromJson<int?>(json['dateAdded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'songId': serializer.toJson<int>(songId),
      'id': serializer.toJson<String>(id),
      'filePath': serializer.toJson<String>(filePath),
      'title': serializer.toJson<String?>(title),
      'artist': serializer.toJson<String?>(artist),
      'album': serializer.toJson<String?>(album),
      'albumId': serializer.toJson<int?>(albumId),
      'artistId': serializer.toJson<int?>(artistId),
      'duration': serializer.toJson<int?>(duration),
      'track': serializer.toJson<int?>(track),
      'genre': serializer.toJson<String?>(genre),
      'dateAdded': serializer.toJson<int?>(dateAdded),
    };
  }

  SongsTableData copyWith({
    int? songId,
    String? id,
    String? filePath,
    Value<String?> title = const Value.absent(),
    Value<String?> artist = const Value.absent(),
    Value<String?> album = const Value.absent(),
    Value<int?> albumId = const Value.absent(),
    Value<int?> artistId = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    Value<int?> track = const Value.absent(),
    Value<String?> genre = const Value.absent(),
    Value<int?> dateAdded = const Value.absent(),
  }) => SongsTableData(
    songId: songId ?? this.songId,
    id: id ?? this.id,
    filePath: filePath ?? this.filePath,
    title: title.present ? title.value : this.title,
    artist: artist.present ? artist.value : this.artist,
    album: album.present ? album.value : this.album,
    albumId: albumId.present ? albumId.value : this.albumId,
    artistId: artistId.present ? artistId.value : this.artistId,
    duration: duration.present ? duration.value : this.duration,
    track: track.present ? track.value : this.track,
    genre: genre.present ? genre.value : this.genre,
    dateAdded: dateAdded.present ? dateAdded.value : this.dateAdded,
  );
  SongsTableData copyWithCompanion(SongsTableCompanion data) {
    return SongsTableData(
      songId: data.songId.present ? data.songId.value : this.songId,
      id: data.id.present ? data.id.value : this.id,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      duration: data.duration.present ? data.duration.value : this.duration,
      track: data.track.present ? data.track.value : this.track,
      genre: data.genre.present ? data.genre.value : this.genre,
      dateAdded: data.dateAdded.present ? data.dateAdded.value : this.dateAdded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SongsTableData(')
          ..write('songId: $songId, ')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('albumId: $albumId, ')
          ..write('artistId: $artistId, ')
          ..write('duration: $duration, ')
          ..write('track: $track, ')
          ..write('genre: $genre, ')
          ..write('dateAdded: $dateAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    songId,
    id,
    filePath,
    title,
    artist,
    album,
    albumId,
    artistId,
    duration,
    track,
    genre,
    dateAdded,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SongsTableData &&
          other.songId == this.songId &&
          other.id == this.id &&
          other.filePath == this.filePath &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.albumId == this.albumId &&
          other.artistId == this.artistId &&
          other.duration == this.duration &&
          other.track == this.track &&
          other.genre == this.genre &&
          other.dateAdded == this.dateAdded);
}

class SongsTableCompanion extends UpdateCompanion<SongsTableData> {
  final Value<int> songId;
  final Value<String> id;
  final Value<String> filePath;
  final Value<String?> title;
  final Value<String?> artist;
  final Value<String?> album;
  final Value<int?> albumId;
  final Value<int?> artistId;
  final Value<int?> duration;
  final Value<int?> track;
  final Value<String?> genre;
  final Value<int?> dateAdded;
  const SongsTableCompanion({
    this.songId = const Value.absent(),
    this.id = const Value.absent(),
    this.filePath = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.albumId = const Value.absent(),
    this.artistId = const Value.absent(),
    this.duration = const Value.absent(),
    this.track = const Value.absent(),
    this.genre = const Value.absent(),
    this.dateAdded = const Value.absent(),
  });
  SongsTableCompanion.insert({
    this.songId = const Value.absent(),
    required String id,
    required String filePath,
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.albumId = const Value.absent(),
    this.artistId = const Value.absent(),
    this.duration = const Value.absent(),
    this.track = const Value.absent(),
    this.genre = const Value.absent(),
    this.dateAdded = const Value.absent(),
  }) : id = Value(id),
       filePath = Value(filePath);
  static Insertable<SongsTableData> custom({
    Expression<int>? songId,
    Expression<String>? id,
    Expression<String>? filePath,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<int>? albumId,
    Expression<int>? artistId,
    Expression<int>? duration,
    Expression<int>? track,
    Expression<String>? genre,
    Expression<int>? dateAdded,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (id != null) 'id': id,
      if (filePath != null) 'file_path': filePath,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (albumId != null) 'album_id': albumId,
      if (artistId != null) 'artist_id': artistId,
      if (duration != null) 'duration': duration,
      if (track != null) 'track': track,
      if (genre != null) 'genre': genre,
      if (dateAdded != null) 'date_added': dateAdded,
    });
  }

  SongsTableCompanion copyWith({
    Value<int>? songId,
    Value<String>? id,
    Value<String>? filePath,
    Value<String?>? title,
    Value<String?>? artist,
    Value<String?>? album,
    Value<int?>? albumId,
    Value<int?>? artistId,
    Value<int?>? duration,
    Value<int?>? track,
    Value<String?>? genre,
    Value<int?>? dateAdded,
  }) {
    return SongsTableCompanion(
      songId: songId ?? this.songId,
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumId: albumId ?? this.albumId,
      artistId: artistId ?? this.artistId,
      duration: duration ?? this.duration,
      track: track ?? this.track,
      genre: genre ?? this.genre,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<int>(songId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<int>(albumId.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<int>(artistId.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (track.present) {
      map['track'] = Variable<int>(track.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<int>(dateAdded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongsTableCompanion(')
          ..write('songId: $songId, ')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('albumId: $albumId, ')
          ..write('artistId: $artistId, ')
          ..write('duration: $duration, ')
          ..write('track: $track, ')
          ..write('genre: $genre, ')
          ..write('dateAdded: $dateAdded')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTableTable extends PlaylistsTable
    with TableInfo<$PlaylistsTableTable, PlaylistsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverArtPathMeta = const VerificationMeta(
    'coverArtPath',
  );
  @override
  late final GeneratedColumn<String> coverArtPath = GeneratedColumn<String>(
    'cover_art_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, coverArtPath, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cover_art_path')) {
      context.handle(
        _coverArtPathMeta,
        coverArtPath.isAcceptableOrUnknown(
          data['cover_art_path']!,
          _coverArtPathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      coverArtPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_art_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlaylistsTableTable createAlias(String alias) {
    return $PlaylistsTableTable(attachedDatabase, alias);
  }
}

class PlaylistsTableData extends DataClass
    implements Insertable<PlaylistsTableData> {
  final int id;
  final String name;
  final String? coverArtPath;
  final DateTime createdAt;
  const PlaylistsTableData({
    required this.id,
    required this.name,
    this.coverArtPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || coverArtPath != null) {
      map['cover_art_path'] = Variable<String>(coverArtPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlaylistsTableCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsTableCompanion(
      id: Value(id),
      name: Value(name),
      coverArtPath: coverArtPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverArtPath),
      createdAt: Value(createdAt),
    );
  }

  factory PlaylistsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      coverArtPath: serializer.fromJson<String?>(json['coverArtPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'coverArtPath': serializer.toJson<String?>(coverArtPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlaylistsTableData copyWith({
    int? id,
    String? name,
    Value<String?> coverArtPath = const Value.absent(),
    DateTime? createdAt,
  }) => PlaylistsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    coverArtPath: coverArtPath.present ? coverArtPath.value : this.coverArtPath,
    createdAt: createdAt ?? this.createdAt,
  );
  PlaylistsTableData copyWithCompanion(PlaylistsTableCompanion data) {
    return PlaylistsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      coverArtPath: data.coverArtPath.present
          ? data.coverArtPath.value
          : this.coverArtPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coverArtPath: $coverArtPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, coverArtPath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.coverArtPath == this.coverArtPath &&
          other.createdAt == this.createdAt);
}

class PlaylistsTableCompanion extends UpdateCompanion<PlaylistsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> coverArtPath;
  final Value<DateTime> createdAt;
  const PlaylistsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.coverArtPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlaylistsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.coverArtPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PlaylistsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? coverArtPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (coverArtPath != null) 'cover_art_path': coverArtPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlaylistsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? coverArtPath,
    Value<DateTime>? createdAt,
  }) {
    return PlaylistsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      coverArtPath: coverArtPath ?? this.coverArtPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coverArtPath.present) {
      map['cover_art_path'] = Variable<String>(coverArtPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coverArtPath: $coverArtPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PlaylistSongsTableTable extends PlaylistSongsTable
    with TableInfo<$PlaylistSongsTableTable, PlaylistSongsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistSongsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playlistIdMeta = const VerificationMeta(
    'playlistId',
  );
  @override
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
    'playlist_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<int> songId = GeneratedColumn<int>(
    'song_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [playlistId, songId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_songs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistSongsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
        _playlistIdMeta,
        playlistId.isAcceptableOrUnknown(data['playlist_id']!, _playlistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('song_id')) {
      context.handle(
        _songIdMeta,
        songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta),
      );
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, songId};
  @override
  PlaylistSongsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistSongsTableData(
      playlistId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}playlist_id'],
      )!,
      songId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}song_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $PlaylistSongsTableTable createAlias(String alias) {
    return $PlaylistSongsTableTable(attachedDatabase, alias);
  }
}

class PlaylistSongsTableData extends DataClass
    implements Insertable<PlaylistSongsTableData> {
  final int playlistId;
  final int songId;
  final int position;
  const PlaylistSongsTableData({
    required this.playlistId,
    required this.songId,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<int>(playlistId);
    map['song_id'] = Variable<int>(songId);
    map['position'] = Variable<int>(position);
    return map;
  }

  PlaylistSongsTableCompanion toCompanion(bool nullToAbsent) {
    return PlaylistSongsTableCompanion(
      playlistId: Value(playlistId),
      songId: Value(songId),
      position: Value(position),
    );
  }

  factory PlaylistSongsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistSongsTableData(
      playlistId: serializer.fromJson<int>(json['playlistId']),
      songId: serializer.fromJson<int>(json['songId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<int>(playlistId),
      'songId': serializer.toJson<int>(songId),
      'position': serializer.toJson<int>(position),
    };
  }

  PlaylistSongsTableData copyWith({
    int? playlistId,
    int? songId,
    int? position,
  }) => PlaylistSongsTableData(
    playlistId: playlistId ?? this.playlistId,
    songId: songId ?? this.songId,
    position: position ?? this.position,
  );
  PlaylistSongsTableData copyWithCompanion(PlaylistSongsTableCompanion data) {
    return PlaylistSongsTableData(
      playlistId: data.playlistId.present
          ? data.playlistId.value
          : this.playlistId,
      songId: data.songId.present ? data.songId.value : this.songId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistSongsTableData(')
          ..write('playlistId: $playlistId, ')
          ..write('songId: $songId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playlistId, songId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistSongsTableData &&
          other.playlistId == this.playlistId &&
          other.songId == this.songId &&
          other.position == this.position);
}

class PlaylistSongsTableCompanion
    extends UpdateCompanion<PlaylistSongsTableData> {
  final Value<int> playlistId;
  final Value<int> songId;
  final Value<int> position;
  final Value<int> rowid;
  const PlaylistSongsTableCompanion({
    this.playlistId = const Value.absent(),
    this.songId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistSongsTableCompanion.insert({
    required int playlistId,
    required int songId,
    required int position,
    this.rowid = const Value.absent(),
  }) : playlistId = Value(playlistId),
       songId = Value(songId),
       position = Value(position);
  static Insertable<PlaylistSongsTableData> custom({
    Expression<int>? playlistId,
    Expression<int>? songId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (songId != null) 'song_id': songId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistSongsTableCompanion copyWith({
    Value<int>? playlistId,
    Value<int>? songId,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return PlaylistSongsTableCompanion(
      playlistId: playlistId ?? this.playlistId,
      songId: songId ?? this.songId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<int>(songId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistSongsTableCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('songId: $songId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $SongsTableTable songsTable = $SongsTableTable(this);
  late final $PlaylistsTableTable playlistsTable = $PlaylistsTableTable(this);
  late final $PlaylistSongsTableTable playlistSongsTable =
      $PlaylistSongsTableTable(this);
  late final SongsDao songsDao = SongsDao(this as AppDb);
  late final PlaylistsDao playlistsDao = PlaylistsDao(this as AppDb);
  late final PlaylistSongsDao playlistSongsDao = PlaylistSongsDao(
    this as AppDb,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    songsTable,
    playlistsTable,
    playlistSongsTable,
  ];
}

typedef $$SongsTableTableCreateCompanionBuilder =
    SongsTableCompanion Function({
      Value<int> songId,
      required String id,
      required String filePath,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<int?> albumId,
      Value<int?> artistId,
      Value<int?> duration,
      Value<int?> track,
      Value<String?> genre,
      Value<int?> dateAdded,
    });
typedef $$SongsTableTableUpdateCompanionBuilder =
    SongsTableCompanion Function({
      Value<int> songId,
      Value<String> id,
      Value<String> filePath,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<int?> albumId,
      Value<int?> artistId,
      Value<int?> duration,
      Value<int?> track,
      Value<String?> genre,
      Value<int?> dateAdded,
    });

class $$SongsTableTableFilterComposer
    extends Composer<_$AppDb, $SongsTableTable> {
  $$SongsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get track => $composableBuilder(
    column: $table.track,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SongsTableTableOrderingComposer
    extends Composer<_$AppDb, $SongsTableTable> {
  $$SongsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get albumId => $composableBuilder(
    column: $table.albumId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get artistId => $composableBuilder(
    column: $table.artistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get track => $composableBuilder(
    column: $table.track,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SongsTableTableAnnotationComposer
    extends Composer<_$AppDb, $SongsTableTable> {
  $$SongsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<int> get albumId =>
      $composableBuilder(column: $table.albumId, builder: (column) => column);

  GeneratedColumn<int> get artistId =>
      $composableBuilder(column: $table.artistId, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get track =>
      $composableBuilder(column: $table.track, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<int> get dateAdded =>
      $composableBuilder(column: $table.dateAdded, builder: (column) => column);
}

class $$SongsTableTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $SongsTableTable,
          SongsTableData,
          $$SongsTableTableFilterComposer,
          $$SongsTableTableOrderingComposer,
          $$SongsTableTableAnnotationComposer,
          $$SongsTableTableCreateCompanionBuilder,
          $$SongsTableTableUpdateCompanionBuilder,
          (
            SongsTableData,
            BaseReferences<_$AppDb, $SongsTableTable, SongsTableData>,
          ),
          SongsTableData,
          PrefetchHooks Function()
        > {
  $$SongsTableTableTableManager(_$AppDb db, $SongsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SongsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SongsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SongsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> songId = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<int?> albumId = const Value.absent(),
                Value<int?> artistId = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<int?> track = const Value.absent(),
                Value<String?> genre = const Value.absent(),
                Value<int?> dateAdded = const Value.absent(),
              }) => SongsTableCompanion(
                songId: songId,
                id: id,
                filePath: filePath,
                title: title,
                artist: artist,
                album: album,
                albumId: albumId,
                artistId: artistId,
                duration: duration,
                track: track,
                genre: genre,
                dateAdded: dateAdded,
              ),
          createCompanionCallback:
              ({
                Value<int> songId = const Value.absent(),
                required String id,
                required String filePath,
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<int?> albumId = const Value.absent(),
                Value<int?> artistId = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<int?> track = const Value.absent(),
                Value<String?> genre = const Value.absent(),
                Value<int?> dateAdded = const Value.absent(),
              }) => SongsTableCompanion.insert(
                songId: songId,
                id: id,
                filePath: filePath,
                title: title,
                artist: artist,
                album: album,
                albumId: albumId,
                artistId: artistId,
                duration: duration,
                track: track,
                genre: genre,
                dateAdded: dateAdded,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SongsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $SongsTableTable,
      SongsTableData,
      $$SongsTableTableFilterComposer,
      $$SongsTableTableOrderingComposer,
      $$SongsTableTableAnnotationComposer,
      $$SongsTableTableCreateCompanionBuilder,
      $$SongsTableTableUpdateCompanionBuilder,
      (
        SongsTableData,
        BaseReferences<_$AppDb, $SongsTableTable, SongsTableData>,
      ),
      SongsTableData,
      PrefetchHooks Function()
    >;
typedef $$PlaylistsTableTableCreateCompanionBuilder =
    PlaylistsTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> coverArtPath,
      Value<DateTime> createdAt,
    });
typedef $$PlaylistsTableTableUpdateCompanionBuilder =
    PlaylistsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> coverArtPath,
      Value<DateTime> createdAt,
    });

class $$PlaylistsTableTableFilterComposer
    extends Composer<_$AppDb, $PlaylistsTableTable> {
  $$PlaylistsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverArtPath => $composableBuilder(
    column: $table.coverArtPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaylistsTableTableOrderingComposer
    extends Composer<_$AppDb, $PlaylistsTableTable> {
  $$PlaylistsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverArtPath => $composableBuilder(
    column: $table.coverArtPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaylistsTableTableAnnotationComposer
    extends Composer<_$AppDb, $PlaylistsTableTable> {
  $$PlaylistsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get coverArtPath => $composableBuilder(
    column: $table.coverArtPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlaylistsTableTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $PlaylistsTableTable,
          PlaylistsTableData,
          $$PlaylistsTableTableFilterComposer,
          $$PlaylistsTableTableOrderingComposer,
          $$PlaylistsTableTableAnnotationComposer,
          $$PlaylistsTableTableCreateCompanionBuilder,
          $$PlaylistsTableTableUpdateCompanionBuilder,
          (
            PlaylistsTableData,
            BaseReferences<_$AppDb, $PlaylistsTableTable, PlaylistsTableData>,
          ),
          PlaylistsTableData,
          PrefetchHooks Function()
        > {
  $$PlaylistsTableTableTableManager(_$AppDb db, $PlaylistsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> coverArtPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlaylistsTableCompanion(
                id: id,
                name: name,
                coverArtPath: coverArtPath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> coverArtPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlaylistsTableCompanion.insert(
                id: id,
                name: name,
                coverArtPath: coverArtPath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaylistsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $PlaylistsTableTable,
      PlaylistsTableData,
      $$PlaylistsTableTableFilterComposer,
      $$PlaylistsTableTableOrderingComposer,
      $$PlaylistsTableTableAnnotationComposer,
      $$PlaylistsTableTableCreateCompanionBuilder,
      $$PlaylistsTableTableUpdateCompanionBuilder,
      (
        PlaylistsTableData,
        BaseReferences<_$AppDb, $PlaylistsTableTable, PlaylistsTableData>,
      ),
      PlaylistsTableData,
      PrefetchHooks Function()
    >;
typedef $$PlaylistSongsTableTableCreateCompanionBuilder =
    PlaylistSongsTableCompanion Function({
      required int playlistId,
      required int songId,
      required int position,
      Value<int> rowid,
    });
typedef $$PlaylistSongsTableTableUpdateCompanionBuilder =
    PlaylistSongsTableCompanion Function({
      Value<int> playlistId,
      Value<int> songId,
      Value<int> position,
      Value<int> rowid,
    });

class $$PlaylistSongsTableTableFilterComposer
    extends Composer<_$AppDb, $PlaylistSongsTableTable> {
  $$PlaylistSongsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaylistSongsTableTableOrderingComposer
    extends Composer<_$AppDb, $PlaylistSongsTableTable> {
  $$PlaylistSongsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaylistSongsTableTableAnnotationComposer
    extends Composer<_$AppDb, $PlaylistSongsTableTable> {
  $$PlaylistSongsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$PlaylistSongsTableTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $PlaylistSongsTableTable,
          PlaylistSongsTableData,
          $$PlaylistSongsTableTableFilterComposer,
          $$PlaylistSongsTableTableOrderingComposer,
          $$PlaylistSongsTableTableAnnotationComposer,
          $$PlaylistSongsTableTableCreateCompanionBuilder,
          $$PlaylistSongsTableTableUpdateCompanionBuilder,
          (
            PlaylistSongsTableData,
            BaseReferences<
              _$AppDb,
              $PlaylistSongsTableTable,
              PlaylistSongsTableData
            >,
          ),
          PlaylistSongsTableData,
          PrefetchHooks Function()
        > {
  $$PlaylistSongsTableTableTableManager(
    _$AppDb db,
    $PlaylistSongsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistSongsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistSongsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistSongsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> playlistId = const Value.absent(),
                Value<int> songId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistSongsTableCompanion(
                playlistId: playlistId,
                songId: songId,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int playlistId,
                required int songId,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => PlaylistSongsTableCompanion.insert(
                playlistId: playlistId,
                songId: songId,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaylistSongsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $PlaylistSongsTableTable,
      PlaylistSongsTableData,
      $$PlaylistSongsTableTableFilterComposer,
      $$PlaylistSongsTableTableOrderingComposer,
      $$PlaylistSongsTableTableAnnotationComposer,
      $$PlaylistSongsTableTableCreateCompanionBuilder,
      $$PlaylistSongsTableTableUpdateCompanionBuilder,
      (
        PlaylistSongsTableData,
        BaseReferences<
          _$AppDb,
          $PlaylistSongsTableTable,
          PlaylistSongsTableData
        >,
      ),
      PlaylistSongsTableData,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$SongsTableTableTableManager get songsTable =>
      $$SongsTableTableTableManager(_db, _db.songsTable);
  $$PlaylistsTableTableTableManager get playlistsTable =>
      $$PlaylistsTableTableTableManager(_db, _db.playlistsTable);
  $$PlaylistSongsTableTableTableManager get playlistSongsTable =>
      $$PlaylistSongsTableTableTableManager(_db, _db.playlistSongsTable);
}
