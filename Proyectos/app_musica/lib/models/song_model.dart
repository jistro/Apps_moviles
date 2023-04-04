import 'dart:io';

class Song {
  String title;
  String artist;
  String album;
  String filePath;

  Song(this.title, this.artist, this.album, this.filePath);

  static Future<List<Song>> loadSongsFromDirectory(String directoryPath) async 
  {
    Directory directory = Directory(directoryPath);
    List<Song> songs_list = [];

    if (await directory.exists()) {
      List<FileSystemEntity> files = directory.listSync(recursive: true);

      for (FileSystemEntity file in files) {
        if (file is File && file.path.endsWith('.mp3')) {
          String fileName = file.path.split('/').last;
          String title = fileName.substring(0, fileName.length - 4); // Eliminar la extensión del archivo (.mp3)
          String artist = 'Desconocido'; // Puede cambiar esto para obtener información de metadatos de la canción
          String album = 'Desconocido'; // Puede cambiar esto para obtener información de metadatos de la canción

          songs_list.add(Song(title, artist, album, file.path));
        }
      }
    }

    return songs_list;
  }
}
