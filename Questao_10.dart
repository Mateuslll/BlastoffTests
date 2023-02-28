import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class ViaCepData {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  ViaCepData({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  factory ViaCepData.fromJson(Map<String, dynamic> json) {
    return ViaCepData(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],
    );
  }
}

class ViaCepError {
  final String message;

  ViaCepError({required this.message});
}

Future<void> fetchViaCepData(String cep, BuildContext context) async {
  try {
    final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
    final jsonMap = jsonDecode(response.data);

    if (jsonMap.containsKey('erro')) {
      throw ViaCepError(message: 'CEP inválido');
    }

    final viaCepData = ViaCepData.fromJson(jsonMap);
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Center(
            child: Text(viaCepData.logradouro),
          ),
        );
      },
    );
  } on DioError catch (e) {
    String errorMessage = 'Ocorreu um erro ao se comunicar com o servidor';
    if (e.response != null && e.response!.data != null) {
      errorMessage = e.response!.data.toString();
    }
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Center(
            child: Text(errorMessage),
          ),
        );
      },
    );
  } on ViaCepError catch (e) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Center(
            child: Text(e.message),
          ),
        );
      },
    );
  } catch (e) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Center(
            child: Text('Ocorreu um erro inesperado'),
          ),
        );
      },
    );
  }
}
