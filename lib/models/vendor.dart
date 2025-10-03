class Vendor {
  final String id;
  final String name;
  final String email;
  final String token;
  final String? phone;
  final String? storeName;
  final String? storeDescription;
  final String? profileImage;
  final bool isVerified;
  final DateTime? createdAt;

  Vendor({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.phone,
    this.storeName,
    this.storeDescription,
    this.profileImage,
    this.isVerified = false,
    this.createdAt,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      phone: json['phone'],
      storeName: json['store_name'],
      storeDescription: json['store_description'],
      profileImage: json['profile_image'],
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'phone': phone,
      'store_name': storeName,
      'store_description': storeDescription,
      'profile_image': profileImage,
      'is_verified': isVerified,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
