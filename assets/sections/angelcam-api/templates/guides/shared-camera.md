Navigation: Shared camera information
SortOrder: 500

# Shared camera information

## Access shared cameras
For access to cameras which somebody shared with you. Use `shared-cameras/` endpoint. This endpoint is basically same as `cameras/` endpoint for accessing your own cameras, including recording access. There is only one difference, `shared-cameras/` endpoint gives you basic information about camera owner.

## Manage Guest
To share your own camera with any other user see *Camera guest resources*. This means, you allow guests to view stream from your camera. There are four kind of operations which is allow for managing guest.

### Retrieve guest
You can retrieve guest email, name and guest permissions.

### Create guest
When you adding new guest, you just need their email. Then we send them an email informing them that you share camera with them. In case when there was no account with given email we precreate an account for these guest.

### Remove guest
You can also remove guest. 

### Update guest
You can update guest permissions. There is currently only one permission `can_view_rec` which allow view also recorded footage (in case the CRA app is active on camera).
