//
//  QueryingInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QueryingInteractorInput {

}

protocol QueryingInteractorOutput {

}

class QueryingInteractor {

    var presenter: QueryingInteractorOutput?

}

extension QueryingInteractor: QueryingInteractorInput {

}
