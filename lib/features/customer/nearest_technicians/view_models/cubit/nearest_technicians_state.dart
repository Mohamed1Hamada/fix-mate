part of 'nearest_technicians_cubit.dart';

@immutable
sealed class NearestTechniciansState {}

final class NearestTechniciansInitial extends NearestTechniciansState {}

final class GetNearestTechniciansLoading extends NearestTechniciansState {}

final class GetNearestTechniciansSuccess extends NearestTechniciansState {}

final class GetNearestTechniciansError extends NearestTechniciansState {
  final String message;
  GetNearestTechniciansError({required this.message});
}
