part of '../../../security.dart';

// Your other imports (Routing, Injection, AuthenticationGuard, ZLogger, LogLevel)

/// Middleware for routes that require authentication.
/// If the user is not authenticated or the session is expired, redirects to the login page.
class RequireAuthMiddleware extends QMiddleware {
  @override
  Future<String?> redirectGuard(String path) async {
    final guard = Injection.serviceLocator<AuthenticationGuard>();
    final authResult = await guard.isUserAuthenticated();

    return authResult.fold(
      (failure) {
        ZLogger(logLevel: LogLevel.ERROR, message: "Auth check failed in RequireAuthMiddleware: ${failure.userMessage}");
        // Redirect to login on failure
        return Routing.to.login.path;
      },
      (isAuthenticated) async {
        if (isAuthenticated == null || !isAuthenticated) {
           ZLogger(logLevel: LogLevel.INFO, message: "RequireAuthMiddleware: User not authenticated. Redirecting to login.");
           // Redirect to login if not authenticated
           return Routing.to.login.path;
        }

        // User is authenticated, check expiration status
        final expiryResult = await guard.isUserExpired();
        return expiryResult.fold(
          (failure) {
             ZLogger(logLevel: LogLevel.ERROR, message: "Expiry check failed in RequireAuthMiddleware: ${failure.userMessage}");
             // Redirect to login on failure
             return Routing.to.login.path;
          },
          (isExpired) {
             if (isExpired == null || isExpired) {
               ZLogger(logLevel: LogLevel.INFO, message: "$isExpired : User session expired or status unknown. Redirecting to login.");
               // Redirect to login if expired or status is unknown
               return Routing.to.login.path;
             }
             // Authenticated and not expired - allow access
             ZLogger(logLevel: LogLevel.INFO, message: "RequireAuthMiddleware: Access granted.");
             return null;
          }
        );
      }
    );
  }
}