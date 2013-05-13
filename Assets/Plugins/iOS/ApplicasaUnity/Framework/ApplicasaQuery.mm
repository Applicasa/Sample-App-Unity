#import "ApplicasaCore.h"
extern "C" {



void ApplicasaQuerySetGeoFilter(LiQuery* query,  LiFields field, struct ApplicasaLocation location, int radius) {
    [query setGeoFilterBy:field Location:[[[CLLocation alloc] initWithLatitude:location.Latitude longitude:location.Longitude] autorelease] Radius:radius];
}

void ApplicasaQueryAddOrder(LiQuery* query,  LiFields field, SortType sortType) {
    [query addOrderByField:field SortType:sortType];
}

void ApplicasaQueryAddPager(LiQuery* query, NSUInteger page, NSUInteger recordsPerPage) {
    [query addPagerByPage:page RecordsPerPage:recordsPerPage];
}

LiQuery* ApplicasaQueryCreate() {
    return [[LiQuery alloc] autorelease];
}

LiFilters* ApplicasaQueryGetFilter(LiQuery* query) {
    return [query filters];
}

void ApplicasaQuerySetFilter(LiQuery* query, LiFilters* filter) {
    query.filters = filter;
}

}