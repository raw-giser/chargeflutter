import 'package:flutter/material.dart';

import './localization.dart';
import './request.dart';
import './globalSingle.dart';
import 'package:fluttertoast/fluttertoast.dart';

GlobalVaribles global = new GlobalVaribles();

class SettingPage extends StatefulWidget {
  @override
  Setting createState() => new Setting();
}

class Setting extends State<SettingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<String, Map<String, dynamic>> _settingConfig = {
    'stationStatusJson': {
      'title': '按状态',
      'items': [
        [
          {'value': 0, 'name': '全部', 'status': true},
          {'value': 1, 'name': '空闲', 'status': false}
        ]
      ]
    },
    'stationLocationJson': {
      'title': '按充电桩位置',
      'items': [
        [
          {'value': 0, 'name': '全部', 'status': true},
          {'value': 1, 'name': '地上', 'status': false},
          {'value': 2, 'name': '地下', 'status': false}
        ]
      ]
    },
    'chargingMethodJson': {
      'title': '按快充慢充',
      'items': [
        [
          {'value': 2, 'name': '全部', 'status': true},
          {'value': 1, 'name': '快充', 'status': false},
          {'value': 0, 'name': '慢充', 'status': false}
        ]
      ]
    },
    'parkingFeeJson': {
      'title': '按停车费用（元/小时）',
      'items': [
        [
          {'value': 2, 'name': '全部', 'status': true},
          {'value': 0, 'name': '免费', 'status': false},
          {'value': 1, 'name': '付费', 'status': false}
        ]
      ]
    },
    'operatorJson': {
      'title': '按运营商',
      'items': [
        [
          {'value': '', 'name': '全部', 'status': true},
          {'value': 7, 'name': '特来电', 'status': false},
          {'value': 6, 'name': '普天', 'status': false}
        ],
        [
          {'value': 25, 'name': '安悦', 'status': false},
          {'value': 16, 'name': '星星充电', 'status': false},
          {'value': 1, 'name': '国网', 'status': false}
        ]
      ]
    },
    'paymentMethodJson': {
      'title': '按支付方式',
      'items': [
        [
          {'value': 0, 'name': '全部', 'status': true},
          {'value': 1, 'name': '可扫码支付', 'status': false},
          {'value': 2, 'name': '其他', 'status': false}
        ]
      ]
    },
  };

  @override
  void initState() {
    super.initState();
    Map<String, String> parameter = {'access_token': global.accessToken};
    fetchGet('wechat/queryUserEXCharge', parameter).then((result) {
      if (result['errcode'] == 0) {
        _settingConfig['stationStatusJson']['items'].forEach((item) {
          item.forEach((subItem) {
            subItem['status'] = false;
            if (subItem['value'] == result['data']['state']) {
              subItem['status'] = true;
            }
          });
        });

        _settingConfig['stationLocationJson']['items'].forEach((item) {
          item.forEach((subItem) {
            subItem['status'] = false;
            if (subItem['value'] == result['data']['position']) {
              subItem['status'] = true;
            }
          });
        });

        _settingConfig['chargingMethodJson']['items'].forEach((item) {
          item.forEach((subItem) {
            subItem['status'] = false;
            if (subItem['value'] == result['data']['charging_mode']) {
              subItem['status'] = true;
            }
          });
        });

        _settingConfig['parkingFeeJson']['items'].forEach((item) {
          item.forEach((subItem) {
            subItem['status'] = false;
            if (subItem['value'] == result['data']['parking_fee']) {
              subItem['status'] = true;
            }
          });

          _settingConfig['operatorJson']['items'].forEach((item) {
            item.forEach((subItem) {
              subItem['status'] = false;
              if (result['data']['servicePro']
                      .indexOf(subItem['value'].toString()) !=
                  -1) {
                subItem['status'] = true;
              }
            });
          });

          _settingConfig['paymentMethodJson']['items'].forEach((item) {
            item.forEach((subItem) {
              subItem['status'] = false;
              if (subItem['value'] == result['data']['payment']) {
                subItem['status'] = true;
              }
            });
          });
        });
      } else {
        print(result['errmsg']);
      }

      setState(() {});
    });
  }

  void onStatusButtonTap(value) {
    _settingConfig['stationStatusJson']['items'].forEach((item) {
      item.forEach((subItem) {
        subItem['status'] = false;
        if (subItem['value'] == value) {
          subItem['status'] = true;
        }
      });
    });
    setState(() {});
  }

  void onChargePositionButtonTap(value) {
    _settingConfig['stationLocationJson']['items'].forEach((item) {
      item.forEach((subItem) {
        subItem['status'] = false;
        if (subItem['value'] == value) {
          subItem['status'] = true;
        }
      });
    });
    setState(() {});
  }

  void onMethodButtonTap(value) {
    _settingConfig['chargingMethodJson']['items'].forEach((item) {
      item.forEach((subItem) {
        subItem['status'] = false;
        if (subItem['value'] == value) {
          subItem['status'] = true;
        }
      });
    });
    setState(() {});
  }

  void onParkingButtonTap(value) {
    _settingConfig['parkingFeeJson']['items'].forEach((item) {
      item.forEach((subItem) {
        subItem['status'] = false;
        if (subItem['value'] == value) {
          subItem['status'] = true;
        }
      });
    });
    setState(() {});
  }

  void onServiceButtonTap(value) {
    _settingConfig['operatorJson']['items'].forEach((item) {
      item.forEach((subItem) {
        if (value == '') {
          if (subItem['value'] == '') {
            if (subItem['status']) {
              // subItem['status'] = false;
            } else {
              subItem['status'] = true;
            }
          } else {
            if (subItem['status']) {
              subItem['status'] = false;
            }
          }
        } else {
          if (subItem['value'] == '') {
            subItem['status'] = false;
          } else {
            if (value.toString() == subItem['value'].toString()) {
              subItem['status'] = !subItem['status'];
            }
          }
        }
      });
    });
    setState(() {});
  }

  void onPaymentButtonTap(value) {
    _settingConfig['paymentMethodJson']['items'].forEach((item) {
      item.forEach((subItem) {
        subItem['status'] = false;
        if (subItem['value'] == value) {
          subItem['status'] = true;
        }
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stationStatusButtons = [];
    _settingConfig['stationStatusJson']['items'].forEach((item) {
      item.forEach((subItem) {
        stationStatusButtons.add(new FlatButton(
          onPressed: () => onStatusButtonTap(subItem['value']),
          color: subItem['status'] ? Colors.green[500] : Colors.grey[500],
          child: new Text(subItem['name']),
        ));
      });
      stationStatusButtons.add(new FlatButton(
        onPressed: () {},
        child: new Text(''),
      ));
    });
    List<Widget> stationLocationButtons = [];
    _settingConfig['stationLocationJson']['items'].forEach((item) {
      item.forEach((subItem) {
        stationLocationButtons.add(new FlatButton(
          onPressed: () => onChargePositionButtonTap(subItem['value']),
          color: subItem['status'] ? Colors.green[500] : Colors.grey[500],
          child: new Text(subItem['name']),
        ));
      });
    });

    List<Widget> chargingMethodButtons = [];
    _settingConfig['chargingMethodJson']['items'].forEach((item) {
      item.forEach((subItem) {
        chargingMethodButtons.add(new FlatButton(
          onPressed: () => onMethodButtonTap(subItem['value']),
          color: subItem['status'] ? Colors.green[500] : Colors.grey[500],
          child: new Text(subItem['name']),
        ));
      });
    });

    List<Widget> parkingFeeButtons = [];
    _settingConfig['parkingFeeJson']['items'].forEach((item) {
      item.forEach((subItem) {
        parkingFeeButtons.add(new FlatButton(
          onPressed: () => onParkingButtonTap(subItem['value']),
          color: subItem['status'] ? Colors.green[500] : Colors.grey[500],
          child: new Text(subItem['name']),
        ));
      });
    });

    List<Widget> operatorButtons = [];
    _settingConfig['operatorJson']['items'].forEach((item) {
      item.forEach((subItem) {
        operatorButtons.add(new FlatButton(
          onPressed: () => onServiceButtonTap(subItem['value']),
          color: subItem['status'] ? Colors.green[500] : Colors.grey[500],
          child: new Text(subItem['name']),
        ));
      });
    });

    List<Widget> paymentMethodButtons = [];
    _settingConfig['paymentMethodJson']['items'].forEach((item) {
      item.forEach((subItem) {
        paymentMethodButtons.add(new FlatButton(
          onPressed: () => onPaymentButtonTap(subItem['value']),
          color: subItem['status'] ? Colors.green[500] : Colors.grey[500],
          child: new Text(subItem['name']),
        ));
      });
    });

    void onSettingSave() {
      num stationStatus;
      num stationLocation;
      num chargingMethod;
      num parkingFee;
      List operator = [];
      String opertorStr = '';
      num paymentMethod;

      //按状态
      _settingConfig['stationStatusJson']['items'].forEach((item) {
        item.forEach((stationStatusItem) {
          if (stationStatusItem['status']) {
            stationStatus = stationStatusItem['value'];
          }
        });
      });

      //快充电桩位置
      _settingConfig['stationLocationJson']['items'].forEach((item) {
        item.forEach((stationLocationItem) {
          if (stationLocationItem['status']) {
            stationLocation = stationLocationItem['value'];
          }
        });
      });

      //快慢冲--单选
      _settingConfig['chargingMethodJson']['items'].forEach((item) {
        item.forEach((chargingMethodItem) {
          if (chargingMethodItem['status']) {
            chargingMethod = chargingMethodItem['value'];
          }
        });
      });

      //停车费用--单选
      _settingConfig['parkingFeeJson']['items'].forEach((item) {
        item.forEach((parkingFeeItem) {
          if (parkingFeeItem['status']) {
            parkingFee = parkingFeeItem['value'];
          }
        });
      });

      //运营商--多选
      _settingConfig['operatorJson']['items'].forEach((item) {
        item.forEach((operatorItem) {
          if (operatorItem['status']) {
            operator.add(operatorItem['value']);
          }
        });
      });
      opertorStr = operator.join('|');

      //支付方式--单选
      _settingConfig['paymentMethodJson']['items'].forEach((item) {
        item.forEach((paymentMethodItem) {
          if (paymentMethodItem['status']) {
            paymentMethod = paymentMethodItem['value'];
          }
        });
      });

      Map<String, String> parameter = {
        'access_token': global.accessToken,
        'parameter':
            '{"parking_fee": $parkingFee,"payment": $paymentMethod,"plot_kind": "2","servicePro": "$opertorStr","charging_mode": $chargingMethod,"state": $stationStatus,"position": $stationLocation}'
      };

      print(parameter['parameter']);

      fetchPost('wechat/saveUserEXCharge', parameter).then((result) {
        if (result['errcode'] == 0) {
          Fluttertoast.showToast(
            msg: "保存成功!",
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          print(result['errmsg']);
        }
      });

      setState(() {});
    }

    void onSettingReset() {
      _settingConfig = {
        'stationStatusJson': {
          'title': '按状态',
          'items': [
            [
              {'value': 0, 'name': '全部', 'status': true},
              {'value': 1, 'name': '空闲', 'status': false}
            ]
          ]
        },
        'stationLocationJson': {
          'title': '按充电桩位置',
          'items': [
            [
              {'value': 0, 'name': '全部', 'status': true},
              {'value': 1, 'name': '地上', 'status': false},
              {'value': 2, 'name': '地下', 'status': false}
            ]
          ]
        },
        'chargingMethodJson': {
          'title': '按快充慢充',
          'items': [
            [
              {'value': 2, 'name': '全部', 'status': true},
              {'value': 1, 'name': '快充', 'status': false},
              {'value': 0, 'name': '慢充', 'status': false}
            ]
          ]
        },
        'parkingFeeJson': {
          'title': '按停车费用（元/小时）',
          'items': [
            [
              {'value': 2, 'name': '全部', 'status': true},
              {'value': 0, 'name': '免费', 'status': false},
              {'value': 1, 'name': '付费', 'status': false}
            ]
          ]
        },
        'operatorJson': {
          'title': '按运营商',
          'items': [
            [
              {'value': '', 'name': '全部', 'status': true},
              {'value': 7, 'name': '特来电', 'status': false},
              {'value': 6, 'name': '普天', 'status': false}
            ],
            [
              {'value': 25, 'name': '安悦', 'status': false},
              {'value': 16, 'name': '星星充电', 'status': false},
              {'value': 1, 'name': '国网', 'status': false}
            ]
          ]
        },
        'paymentMethodJson': {
          'title': '按支付方式',
          'items': [
            [
              {'value': 0, 'name': '全部', 'status': true},
              {'value': 1, 'name': '可扫码支付', 'status': false},
              {'value': 2, 'name': '其他', 'status': false}
            ]
          ]
        },
      };

      onSettingSave();
    }

    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            ChargeLocalizations.of(context).settingTitle,
            style: new TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                  onPressed: onSettingReset, child: const Text('重置')),
              new FlatButton(onPressed: onSettingSave, child: const Text('保存'))
            ],
          ),
        ),
        body: new Column(
          children: [
            new Row(
              children: [
                new Text(_settingConfig['stationStatusJson']['title']),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: stationStatusButtons,
                  ),
                )
              ],
            ),
            new Row(
              children: [
                new Text(_settingConfig['stationLocationJson']['title']),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: stationLocationButtons,
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(_settingConfig['chargingMethodJson']['title']),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: chargingMethodButtons,
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(_settingConfig['parkingFeeJson']['title']),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: parkingFeeButtons,
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(_settingConfig['operatorJson']['title']),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: operatorButtons.sublist(0, 3),
                  ),
                )
              ],
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 8.0),
            ),
            new Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: operatorButtons.sublist(3),
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(_settingConfig['paymentMethodJson']['title']),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: paymentMethodButtons,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
