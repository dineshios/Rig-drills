// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   People API (people/v1)
// Description:
//   Provides access to information about profiles and contacts.
// Documentation:
//   https://developers.google.com/people/

#import <GoogleAPIClientForREST/GTLRPeopleService.h>

// ----------------------------------------------------------------------------
// Authorization scopes

NSString * const kGTLRAuthScopePeopleServiceContacts           = @"https://www.googleapis.com/auth/contacts";
NSString * const kGTLRAuthScopePeopleServiceContactsOtherReadonly = @"https://www.googleapis.com/auth/contacts.other.readonly";
NSString * const kGTLRAuthScopePeopleServiceContactsReadonly   = @"https://www.googleapis.com/auth/contacts.readonly";
NSString * const kGTLRAuthScopePeopleServiceDirectoryReadonly  = @"https://www.googleapis.com/auth/directory.readonly";
NSString * const kGTLRAuthScopePeopleServiceUserAddressesRead  = @"https://www.googleapis.com/auth/user.addresses.read";
NSString * const kGTLRAuthScopePeopleServiceUserBirthdayRead   = @"https://www.googleapis.com/auth/user.birthday.read";
NSString * const kGTLRAuthScopePeopleServiceUserEmailsRead     = @"https://www.googleapis.com/auth/user.emails.read";
NSString * const kGTLRAuthScopePeopleServiceUserGenderRead     = @"https://www.googleapis.com/auth/user.gender.read";
NSString * const kGTLRAuthScopePeopleServiceUserinfoEmail      = @"https://www.googleapis.com/auth/userinfo.email";
NSString * const kGTLRAuthScopePeopleServiceUserinfoProfile    = @"https://www.googleapis.com/auth/userinfo.profile";
NSString * const kGTLRAuthScopePeopleServiceUserOrganizationRead = @"https://www.googleapis.com/auth/user.organization.read";
NSString * const kGTLRAuthScopePeopleServiceUserPhonenumbersRead = @"https://www.googleapis.com/auth/user.phonenumbers.read";

// ----------------------------------------------------------------------------
//   GTLRPeopleServiceService
//

@implementation GTLRPeopleServiceService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://people.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
