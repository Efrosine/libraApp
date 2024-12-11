import 'package:flutter/material.dart';
import 'package:myapp/entity/book_entity.dart';

class LendingEntity {
  final int? id;
  final int? userId;
  final String? lentAt;
  final LendStatus? status;
  final String? returnedAt;
  final String? notes;
  final BookEntity? book;

  const LendingEntity({
    this.id,
    this.userId,
    this.lentAt,
    this.status,
    this.returnedAt,
    this.notes,
    this.book,
  });

  const LendingEntity.empty()
      : id = null,
        userId = null,
        lentAt = null,
        status = LendStatus.pending,
        returnedAt = null,
        notes = null,
        book =const BookEntity.empty();

  factory LendingEntity.fromJson(Map<String, dynamic> json) {
    return LendingEntity(
      id: json['id'],
      userId: json['user_id'],
      lentAt: json['lent_at'],
      status: LendStatus.fromString(json['status']),
      returnedAt: json['returned_at'],
      notes: json['notes'],
      book: BookEntity.fromJson(json['book']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'book_id': book?.id,
      'lent_at': lentAt,
      'status': status?.name.toLowerCase(),
      'returned_at': returnedAt,
      'notes': notes,
    };
  }

  LendingEntity copyWith({
    int? id,
    int? userId,
    String? lentAt,
    LendStatus? status,
    String? returnedAt,
    String? notes,
    BookEntity? book,
  }) {
    return LendingEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lentAt: lentAt ?? this.lentAt,
      status: status ?? this.status,
      returnedAt: returnedAt ?? this.returnedAt,
      notes: notes ?? this.notes,
      book: book ?? this.book,
    );
  }

  @override
  String toString() {
    return 'id: $id \n'
        'userId: $userId \n'
        'lentAt: $lentAt \n'
        'status: $status \n'
        'returnedAt: $returnedAt \n'
        'notes: $notes \n';
  }
}

enum LendStatus {
  pending(color: Color.fromRGBO(255, 249, 196, 1)),
  approved(color: Color.fromRGBO(201, 255, 196, 1)),
  declined(color: Color.fromRGBO(255, 205, 210, 1)),
  returned(color: Color.fromRGBO(179, 229, 252, 1));

  final Color? color;

  const LendStatus({required this.color});

  // Menentukan nama status
  String get name {
    switch (this) {
      case LendStatus.pending:
        return "Pending";
      case LendStatus.approved:
        return "Approved";
      case LendStatus.declined:
        return "Declined";
      case LendStatus.returned:
        return "Returned";
      default:
        return "";
    }
  }

  // Menentukan status berdasarkan string
  static LendStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return LendStatus.pending;
      case 'approved':
        return LendStatus.approved;
      case 'declined':
        return LendStatus.declined;
      case 'returned':
        return LendStatus.returned;
      default:
        throw Exception("Invalid status: $status");
    }
  }
}
