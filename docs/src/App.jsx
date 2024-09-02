import React from 'react'
import Header from './components/Header/Header'
import Home from './components/Home/Home'
import About from './components/About/About'
import Pricing from './components/Pricing/Pricing'
import Contact from './components/Contact/Contact'
import Footer from './components/Footer/Footer'
import Testimonials from './components/Testimonials/Testmonials'
import Service from './components/Service/Service'
import DownloadLink from './components/DownloadLink/DownloadLink'

const App = () => {
    return (
        <div>
            <Header />
            <section>
                <Home />
            </section>

            <section>
                <About />
            </section>

            <section>
                <Service />
            </section>

            <section>
                <Testimonials />
            </section>

            <section>
                <Pricing />
            </section>

            <section>
                <DownloadLink />
            </section>


            <section>
                <Contact />
            </section>

            <Footer />
        </div>
    )
}

export default App