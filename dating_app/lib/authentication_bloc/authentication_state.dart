// import 'package:equatable/equatable.dart';

// abstract class AuthenticationState extends Equatable {
//   const AuthenticationState();
//   @override
//   List<Object> get props => [];
// }

// class Uinitialized extends AuthenticationState {}

// class Authenticated extends AuthenticationState {
//   final String userId;
//   const Authenticated(this.userId);

//   @override
//   List<Object> get props => [userId];

//   @override
//   String toString() => 'Authenticated { userId: $userId }';
// }

// class Unauthenticated extends AuthenticationState {
//   @override
//   String toString() => 'Unauthenticated';

//   @override
//   List<Object> get props => [];
// }

// class AuthenticatedButNotSet extends AuthenticationState {
//   final String userId;
//   const AuthenticatedButNotSet(this.userId);
//   @override
//   List<Object> get props => [userId];
// }