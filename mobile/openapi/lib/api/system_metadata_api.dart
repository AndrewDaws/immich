//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SystemMetadataApi {
  SystemMetadataApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// This endpoint is an admin-only route, and requires the `systemMetadata.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAdminOnboardingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/system-metadata/admin-onboarding';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint is an admin-only route, and requires the `systemMetadata.read` permission.
  Future<AdminOnboardingUpdateDto?> getAdminOnboarding() async {
    final response = await getAdminOnboardingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AdminOnboardingUpdateDto',) as AdminOnboardingUpdateDto;
    
    }
    return null;
  }

  /// This endpoint is an admin-only route, and requires the `systemMetadata.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getReverseGeocodingStateWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/system-metadata/reverse-geocoding-state';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint is an admin-only route, and requires the `systemMetadata.read` permission.
  Future<ReverseGeocodingStateResponseDto?> getReverseGeocodingState() async {
    final response = await getReverseGeocodingStateWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReverseGeocodingStateResponseDto',) as ReverseGeocodingStateResponseDto;
    
    }
    return null;
  }

  /// This endpoint is an admin-only route, and requires the `systemMetadata.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVersionCheckStateWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final apiPath = r'/system-metadata/version-check-state';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint is an admin-only route, and requires the `systemMetadata.read` permission.
  Future<VersionCheckStateResponseDto?> getVersionCheckState() async {
    final response = await getVersionCheckStateWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'VersionCheckStateResponseDto',) as VersionCheckStateResponseDto;
    
    }
    return null;
  }

  /// This endpoint is an admin-only route, and requires the `systemMetadata.update` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AdminOnboardingUpdateDto] adminOnboardingUpdateDto (required):
  Future<Response> updateAdminOnboardingWithHttpInfo(AdminOnboardingUpdateDto adminOnboardingUpdateDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/system-metadata/admin-onboarding';

    // ignore: prefer_final_locals
    Object? postBody = adminOnboardingUpdateDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint is an admin-only route, and requires the `systemMetadata.update` permission.
  ///
  /// Parameters:
  ///
  /// * [AdminOnboardingUpdateDto] adminOnboardingUpdateDto (required):
  Future<void> updateAdminOnboarding(AdminOnboardingUpdateDto adminOnboardingUpdateDto,) async {
    final response = await updateAdminOnboardingWithHttpInfo(adminOnboardingUpdateDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
