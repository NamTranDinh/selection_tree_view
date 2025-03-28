class PermissionModel {
  PermissionModel({
    this.id,
    this.code,
    this.name,
    this.path,
  });

  PermissionModel.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    path = json['path'];
  }

  int? id;
  String? code;
  String? name;
  String? path;

  PermissionModel copyWith({
    int? id,
    String? code,
    String? name,
    String? path,
  }) =>
      PermissionModel(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        path: path ?? this.path,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['path'] = path;
    return map;
  }

  static List<PermissionModel> fakeData() {
    return [
      {
        'id': 1,
        'code': 'VIEW_USERS',
        'name': ' View Users',
        'path': r' access management\\user management',
      },
      {
        'id': 2,
        'code': 'UPDATE_USERS',
        'name': ' Update Users',
        'path': r' access management\\user management',
      },
      {
        'id': 3,
        'code': 'VIEW_ROLES',
        'name': ' View Roles',
        'path': r' access management\\role management',
      },
      {
        'id': 4,
        'code': 'UPDATE_ROLES',
        'name': ' Update Roles',
        'path': r' access management\\role management',
      },
      {
        'id': 178,
        'code': 'VIEW_BAND_CATEGORY',
        'name': ' View Band Category',
        'path': r' category management\\band category',
      },
      {
        'id': 179,
        'code': 'UPDATE_BAND_CATEGORY',
        'name': ' Update Band Category',
        'path': r' category management\\band category',
      },
      {
        'id': 199,
        'code': 'VIEW_CUTOFF_TIME',
        'name': ' View Cutoff Time',
        'path': r' category management\\cutoff time',
      },
      {
        'id': 200,
        'code': 'UPDATE_CUTOFF_TIME',
        'name': ' Update Cutoff Time',
        'path': r' category management\\cutoff time',
      },
      {
        'id': 201,
        'code': 'VIEW_CLIENT_ACCOUNT_TYPE',
        'name': ' View Client Account Type',
        'path': r' category management\\client account type',
      },
      {
        'id': 202,
        'code': 'UPDATE_CLIENT_ACCOUNT_TYPE',
        'name': ' Update Client Account Type',
        'path': r' category management\\client account type',
      },
      {
        'id': 203,
        'code': 'VIEW_OVERDRAWABLE_CLIENT',
        'name': ' View Overdrawable Client',
        'path': r' category management\\overdrawable client',
      },
      {
        'id': 204,
        'code': 'UPDATE_OVERDRAWABLE_CLIENT',
        'name': ' Update Overdrawable Client',
        'path': r' category management\\overdrawable client',
      },
      {
        'id': 232,
        'code': 'VIEW_JOURNAL_CODE',
        'name': ' View Journal Code',
        'path': r' category management\\journal code',
      },
      {
        'id': 233,
        'code': 'UPDATE_JOURNAL_CODE',
        'name': ' Update Journal Code',
        'path': r' category management\\journal code',
      },
      {
        'id': 265,
        'code': 'VIEW_CURRENCY_HOLIDAY',
        'name': ' View Holiday',
        'path': r' category management\\currency holiday',
      },
      {
        'id': 266,
        'code': 'UPDATE_CURRENCY_HOLIDAY',
        'name': ' Update Holiday',
        'path': r' category management\\currency holiday',
      },
      {
        'id': 298,
        'code': 'VIEW_BANK_ACCOUNT',
        'name': ' View Bank Account',
        'path': r' onboarding\\bank account',
      },
      {
        'id': 299,
        'code': 'UPDATE_BANK_ACCOUNT',
        'name': ' Update Bank Account',
        'path': r' onboarding\\bank account',
      },
      {
        'id': 331,
        'code': 'VIEW_WITHDRAWAL',
        'name': ' View Withdrawal',
        'path': r' client transactions\\withdrawal',
      },
      {
        'id': 529,
        'code': 'VIEW_BROKER_ACCOUNT_TYPE',
        'name': ' View Broker Account Type',
        'path': r' category management\\broker account type',
      },
      {
        'id': 530,
        'code': 'UPDATE_BROKER_ACCOUNT_TYPE',
        'name': ' Update Broker Account Type',
        'path': r' category management\\broker account type',
      },
      {
        'id': 397,
        'code': 'VIEW_DEPOSIT',
        'name': ' View Deposit',
        'path': r' client transactions\\deposit',
      },
      {
        'id': 399,
        'code': 'MARK_RECEIVE_DEPOSIT',
        'name': ' Mark as received',
        'path': r' client transactions\\deposit',
      },
      {
        'id': 400,
        'code': 'MARK_DONE_DEPOSIT',
        'name': ' Mark as done',
        'path': r' client transactions\\deposit',
      },
      {
        'id': 364,
        'code': 'APPROVE_WITHDRAWAL',
        'name': ' Approve Withdrawal',
        'path': r' client transactions\\withdrawal',
      },
      {
        'id': 365,
        'code': 'REVIEW_WITHDRAWAL',
        'name': ' Review Withdrawal',
        'path': r' client transactions\\withdrawal',
      },
      {
        'id': 366,
        'code': 'CONDUCT_WITHDRAWAL',
        'name': ' Conduct Withdrawal',
        'path': r' client transactions\\withdrawal',
      },
      {
        'id': 463,
        'code': 'VIEW_TRANSACTION_QUEUE',
        'name': ' View Transaction Queue',
        'path': ' transaction queue',
      },
      {
        'id': 496,
        'code': 'VIEW_BAKING_SSI',
        'name': ' View OFIS Banking Ssi',
        'path': r' category management\\banking ssi',
      },
      {
        'id': 497,
        'code': 'UPDATE_BAKING_SSI',
        'name': ' Update OFIS Banking Ssi',
        'path': r' category management\\banking ssi',
      },
      {
        'id': 332,
        'code': 'UPDATE_WITHDRAWAL',
        'name': ' Create Withdrawal',
        'path': r' client transactions\\withdrawal',
      },
      {
        'id': 398,
        'code': 'UPDATE_DEPOSIT',
        'name': ' Create Deposit',
        'path': r' client transactions\\deposit',
      },
      {
        'id': 431,
        'code': 'UPDATE_TRANSFER',
        'name': ' Create Transfer',
        'path': r' client transactions\\transfer',
      },
      {
        'id': 430,
        'code': 'VIEW_TRANSFER',
        'name': ' View Transfer',
        'path': r' client transactions\\transfer',
      },
      {
        'id': 432,
        'code': 'APPROVE_TRANSFER',
        'name': ' Approve Transfer',
        'path': r' client transactions\\transfer',
      },
      {
        'id': 563,
        'code': 'UPDATE_BROKER_WITHDRAWAL',
        'name': ' Update Broker Transaction Withdrawal',
        'path': r' broker transactions\\withdrawal',
      },
      {
        'id': 562,
        'code': 'VIEW_BROKER_WITHDRAWAL',
        'name': ' View Broker Transaction Withdrawal',
        'path': r' broker transactions\\withdrawal',
      },
    ].map(PermissionModel.fromJson).toList();
  }
}
