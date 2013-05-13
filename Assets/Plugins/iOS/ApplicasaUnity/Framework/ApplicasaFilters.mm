#import "ApplicasaCore.h"

extern "C" {
    
LiFilters* ApplicasaFilterNot(LiFilters* filter) {
    return [filter NOT];
}

LiFilters* ApplicasaFilterByFieldInt(LiFields field, OPERATORS op, int val) {
    return [LiFilters filterByField:field Operator:op Value:[NSNumber numberWithInt:val]];
}

LiFilters* ApplicasaFilterByFieldFloat(LiFields field, OPERATORS op, float val) {
    return [LiFilters filterByField:field Operator:op Value:[NSNumber numberWithFloat:val]];
}

LiFilters* ApplicasaFilterByFieldBool(LiFields field, OPERATORS op, bool val) {
    return [LiFilters filterByField:field Operator:op Value:(val ? kLiTrue: kLiFalse)];
}

LiFilters* ApplicasaFilterByFieldString(LiFields field, OPERATORS op, const char* val) {
    return [LiFilters filterByField:field Operator:op Value:CharPointerToNSString(val)];
}

LiFilters* ApplicasaFilterByOperand(LiFilters* OperandA, COMPLEX_OPERATORS op, LiFilters* OperandB) {
    return [LiFilters filterByOperandA:OperandA ComplexOperator:op OperandB:OperandB];
}

LiFilters* ApplicasaFilterByFieldArrayInt(LiFields field, int* array, int arrayLen) {
    NSMutableArray * targetArray = [[[NSMutableArray alloc] initWithCapacity:arrayLen] autorelease];
    NSNumber * number;
    for (int i = 0; i < arrayLen; i++) {
        number = [NSNumber numberWithInt:array[i]];
        [targetArray addObject:number];
    }
    return [LiFilters filterByField:field InOperatorWithArrayOfValues:targetArray];
}

LiFilters* ApplicasaFilterByFieldArrayFloat(LiFields field, float* array, int arrayLen) {
    NSMutableArray * targetArray = [[[NSMutableArray alloc] initWithCapacity:arrayLen] autorelease];
    NSNumber * number;
    for (int i = 0; i < arrayLen; i++) {
        number = [NSNumber numberWithFloat:array[i]];
        [targetArray addObject:number];
    }
    return [LiFilters filterByField:field InOperatorWithArrayOfValues:targetArray];
}

LiFilters* ApplicasaFilterByFieldArrayBool(LiFields field, bool* array, int arrayLen) {
    NSMutableArray * targetArray = [[[NSMutableArray alloc] initWithCapacity:arrayLen] autorelease];
    for (int i = 0; i < arrayLen; i++) {
        [targetArray addObject: (array[i] ? kLiTrue : kLiFalse)];
    }
    return [LiFilters filterByField:field InOperatorWithArrayOfValues:targetArray];
}

LiFilters* ApplicasaFilterByFieldArrayString(LiFields field, char** array, int arrayLen) {
    NSMutableArray * targetArray = [[[NSMutableArray alloc] initWithCapacity:arrayLen] autorelease];
    for (int i = 0; i < arrayLen; i++) {
        [targetArray addObject:CharPointerToNSString(array[i])];
    }
    return [LiFilters filterByField:field InOperatorWithArrayOfValues:targetArray];
}

}