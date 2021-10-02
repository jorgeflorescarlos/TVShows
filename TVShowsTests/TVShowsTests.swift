//
//  TVShowsTests.swift
//  TVShowsTests
//
//  Created by Jorge Flores Carlos on 29/09/21.
//

import XCTest
@testable import TVShows

class TVShowsTests: XCTestCase {

    func testEntity(){
        let tvShow = TVShow(
            id: 495,
            isFavorite: true,
            name: "Naruto",
            externals:
                Externals(
                    tvrage: 4620,
                    thetvdb: 78857,
                    imdb: "tt0409591"
                ),
            image: Image(
                medium: "https://static.tvmaze.com/uploads/images/medium_portrait/3/9744.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/3/9744.jpg"
            ),
            summary: "<p><b>Naruto</b> closely follows the life of a boy who is feared and detested by the villagers of the hidden leaf village of Konoha. The distrust of the boy has little to do with the boy himself, but it's what's inside him that causes anxiety. Long before Naruto came to be, a Kyuubi (demon fox) with great fury and power waged war taking many lives. The battle ensued for a long time until a man known as the Fourth Hokage, Yondaime, the strongest ninja in Konoha, fiercely fought the Kyuubi. The fight was soon won by Yondaime as he sealed the evil demon in a human body. Thus the boy, Naruto, was born. As Naruto grows he decides to become the strongest ninja in Konoha in an effort to show everyone that he is not as they perceive him to be, but is a human being worthy of love and admiration. But the road to becoming Hokage, the title for the strongest ninja in Konoha, is a long and arduous one. It is a path filled with betrayal, pain, and loss; but with hard work, Naruto may achieve Hokage.</p>"
        )
        
        XCTAssertNotNil(tvShow)
        XCTAssertEqual("Naruto", tvShow.name)
        XCTAssertNotNil(tvShow.image)
        XCTAssertNotNil(tvShow.image.medium)
        XCTAssertNotNil(tvShow.image.original)
    }
    
    func testEmptyImdbId() {
        let tvShow = TVShow(
            id: 495,
            isFavorite: true,
            name: "Naruto",
            externals:
                Externals(
                    tvrage: 4620,
                    thetvdb: 78857,
                    imdb: nil
                ),
            image: Image(
                medium: "https://static.tvmaze.com/uploads/images/medium_portrait/3/9744.jpg",
                original: "https://static.tvmaze.com/uploads/images/original_untouched/3/9744.jpg"
            ),
            summary: "<p><b>Naruto</b> closely follows the life of a boy who is feared and detested by the villagers of the hidden leaf village of Konoha. The distrust of the boy has little to do with the boy himself, but it's what's inside him that causes anxiety. Long before Naruto came to be, a Kyuubi (demon fox) with great fury and power waged war taking many lives. The battle ensued for a long time until a man known as the Fourth Hokage, Yondaime, the strongest ninja in Konoha, fiercely fought the Kyuubi. The fight was soon won by Yondaime as he sealed the evil demon in a human body. Thus the boy, Naruto, was born. As Naruto grows he decides to become the strongest ninja in Konoha in an effort to show everyone that he is not as they perceive him to be, but is a human being worthy of love and admiration. But the road to becoming Hokage, the title for the strongest ninja in Konoha, is a long and arduous one. It is a path filled with betrayal, pain, and loss; but with hard work, Naruto may achieve Hokage.</p>"
        )
        XCTAssertNotNil(tvShow)
        XCTAssertNil(tvShow.externals.imdb)
    }
    
}
