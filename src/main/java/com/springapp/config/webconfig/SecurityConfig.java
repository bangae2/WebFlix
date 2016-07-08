package com.springapp.config.webconfig;

import com.springapp.users.entity.UsersEntity;
import com.springapp.users.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.security.Principal;

/**
 * Created by bangae11 on 2016-06-19.
 */
@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = {"com.springapp.users", "com.springapp.config"})
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private UsersService usersService;
    @Autowired
    private DataSourceConfig dataSource;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(usersService).passwordEncoder(new ShaPasswordEncoder());
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**/*").antMatchers("/signup").antMatchers("/forgotPassword").antMatchers("/attach/**/thumbnail/*")
        .antMatchers("/findPassword");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests().anyRequest().authenticated().antMatchers("/login").permitAll().antMatchers("/admin").hasRole("ADMIN")
                .and().csrf().disable()
                .formLogin().loginPage("/login").loginProcessingUrl("/loginProcess").permitAll().usernameParameter("id").passwordParameter("password").defaultSuccessUrl("/")
                .failureHandler(customAuthenticationFailureHandler()).successForwardUrl("/").permitAll()
                .and().logout().deleteCookies("JSESSIONID").logoutRequestMatcher(new AntPathRequestMatcher("/logout")).logoutSuccessUrl("/").permitAll()
                .and().rememberMe().tokenValiditySeconds(1209600).rememberMeParameter("remember-me").key("uniqueAndSecret")
                .and().sessionManagement().maximumSessions(2).expiredUrl("/login");

    }

    public AuthenticationFailureHandler customAuthenticationFailureHandler() {
        AuthenticationFailureHandler fail = new AuthenticationFailureHandler() {
            @Override
            public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
                System.out.println("login Filed ::: " + exception.getMessage());
                response.sendRedirect("/login");
            }
        };
        return fail;
    }

    public AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
        AuthenticationSuccessHandler suss = new AuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                HttpSession session = request.getSession();
                System.out.println("Login Success ::: " + authentication.getDetails());
                RequestDispatcher rd = request.getRequestDispatcher("/");
                UsersEntity usersEntity  = (UsersEntity) authentication.getPrincipal();
                session.setAttribute("username", usersEntity.getUsername());
                session.setAttribute("authorities", authentication.getAuthorities());
                response.setStatus(HttpServletResponse.SC_OK);
                rd.forward(request, response);

            }
        };
        return suss;
    }
}
