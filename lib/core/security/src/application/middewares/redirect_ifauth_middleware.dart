part of '../../../security.dart';

/// Middleware for routes like login/signup.
/// If the user is already authenticated and the session is valid, redirects them to the dashboard.
class RedirectIfAuthenticatedMiddleware extends QMiddleware {
  @override
  Future<String?> redirectGuard(String path) async {
    final guard = Injection.serviceLocator<AuthenticationGuard>();
    final authResult = await guard.isUserAuthenticated();

    return authResult.fold(
      (failure) {
         ZLogger(logLevel: LogLevel.WARNING, message: "Auth check failed in RedirectIfAuthenticatedMiddleware: ${failure.userMessage}. Allowing access.");
         // Allow access on failure (user should be able to login)
         return null;
      },
      (isAuthenticated) async {
        if (isAuthenticated != null && isAuthenticated) {
          // User is authenticated, check expiration status
          final expiryResult = await guard.isUserExpired();
          return expiryResult.fold(
            (failure) {
               ZLogger(logLevel: LogLevel.WARNING, message: "Expiry check failed in RedirectIfAuthenticatedMiddleware: ${failure.userMessage}. Allowing access.");
               // Allow access on failure (session might be expired, requiring re-login)
               return null;
            },
            (isExpired) {
              if (isExpired != null && !isExpired) {
                // Authenticated and not expired - redirect to dashboard
                ZLogger(logLevel: LogLevel.INFO, message: "RedirectIfAuthenticatedMiddleware: User already authenticated and session valid. Redirecting to dashboard.");
                // Redirect to dashboard
                return Routing.to.dashboard.path;
              }
              // Expired or unknown status - allow access (user should be able to login)
              ZLogger(logLevel: LogLevel.INFO, message: "RedirectIfAuthenticatedMiddleware: Session expired or status unknown. Allowing access to login/signup.");
              return null;
            }
          );
        }
        // Not authenticated - allow access (user should be able to login/signup)
        ZLogger(logLevel: LogLevel.INFO, message: "RedirectIfAuthenticatedMiddleware: User not authenticated. Allowing access to login/signup.");
        return null;
      }
    );
  }
}