import 'package:empresta_app_mobile/src/domain/models/version_model.dart';

const VersionModel kAppVersion = VersionModel(major: 1, minor: 0, patch: 0);

/// Aqui pode haver três opções de conexão, sendo a primeira via host da api,
/// a segunda via endereço para dispositivo virtual(Emulador)
/// e a terceira para dispositivo físico caso use um celular real conectado ao computador
/// sendo necessário pegar o ip da máquina.

// const String kBaseApiUrl = "http://127.0.0.1:8000";
// const String kBaseApiUrl = "http://10.0.2.2:8000";
const String kBaseApiUrl = "http://192.168.0.18:8000";
